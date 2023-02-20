//
//  AdManager.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Firebase
import FirebaseAnalytics
import Foundation
import JGProgressHUD
import ObjectMapper
import SwiftyJSON

typealias BFAdComplete = () -> Void
typealias BFAdFailure = () -> Void

// MARK: - AdManager

class AdManager: NSObject {
    private var remote = RemoteConfig.remoteConfig()
    private var settings = RemoteConfigSettings()
    private var expirationDuration: TimeInterval = 0

    var remoteModel = BFRemoteModel()

    // Controller cần hiển thị quảng cáo
    var controller: UIViewController?

    // Callback cho quảng cáo full
    var complete: BFAdComplete?

    // Callback cho quảng cáo reward
    var rewardComplete: BFAdComplete?
    var rewardFailure: BFAdFailure?

    // Loading
    private var hud = JGProgressHUD(style: .dark)

    public static let shared: AdManager = {
        let instance = AdManager()
        instance.settings.minimumFetchInterval = 0
        instance.remote.configSettings = instance.settings
        return instance
    }()

    func config(complete: @escaping () -> Void) {
        remote.fetch(withExpirationDuration: expirationDuration) { [self] status, _ in
            guard status == .success else {
                return
            }
            let j = remote["node"].jsonValue ?? 0
            log.info("Remote Config: \(j)")
            remote.activate(completion: nil)
            let data = remote["node"].dataValue
            do {
                let JSON = try JSON(data: data)
                remoteModel = BFRemoteModel(JSON: JSON.rawValue as! [String: Any]) ?? BFRemoteModel()
                self.setupIronSource()
                complete()
            } catch let e {
                log.error("\(e)")
            }
        }
    }

    func setupIronSource() {
        log.debug("Enable IronSource Ad")
        if remoteModel.enableAd == 0 { return }
        IronSource.initWithAppKey(remoteModel.ironAppKey)
        IronSource.initWithAppKey(remoteModel.ironAppKey)
        ISIntegrationHelper.validateIntegration()
        IronSource.hasRewardedVideo()
    }
}

extension AdManager {
    /// Hiển thị quảng cáo full từ 1 controller
    /// quảng cáo này bị phụ thuộc vào start - loop firebase config
    ///
    /// - Parameters:
    ///     - from controller: Controller nơi cần hiển thị quảng cáo
    ///     - complete: Closure thông báo kết thúc việc hiển thị quảng cáo
    ///
    ///
    func showFull(from controller: UIViewController,
                  complete: @escaping BFAdComplete)
    {
        let remoteModel = self.remoteModel

        if remoteModel.enableAd != 1 {
            complete()
            return
        }

        if remoteModel.ironAppKey.isEmpty {
            complete()
            return
        }

        if remoteModel.fullLoop.validateLoop() == false {
            complete()
            return
        }

        self.complete = complete
        self.controller = controller

        DispatchQueue.main.async {
            self.hud.show(in: self.controller!.view, animated: true)
        }

        IronSource.loadInterstitial()
        IronSource.setInterstitialDelegate(self)
    }

    /// Hiển thị quảng cáo full từ 1 controller
    /// quảng cáo full này KHÔNG bị phụ thuộc vào loop từ firebase config
    ///
    /// - Parameters:
    ///     - from controller: Controller nơi cần hiển thị quảng cáo
    ///     - complete: Closure thông báo kết thúc việc hiển thị quảng cáo
    ///
    ///
    func showFullWithoutLoop(from controller: UIViewController,
                             complete: @escaping BFAdComplete)
    {
        let remoteModel = self.remoteModel

        if remoteModel.enableAd != 1 {
            complete()
            return
        }

        if remoteModel.ironAppKey.isEmpty {
            complete()
            return
        }

        self.complete = complete
        self.controller = controller

        DispatchQueue.main.async {
            self.hud.show(in: self.controller!.view, animated: true)
        }

        IronSource.loadInterstitial()
        IronSource.setInterstitialDelegate(self)
    }

    /// Hiển thị quảng cáo REWARD   từ 1 controller
    /// quảng cáo full này KHÔNG bị phụ thuộc vào loop từ firebase config
    ///
    /// - Parameters:
    ///     - from controller: Controller nơi cần hiển thị quảng cáo
    ///     - complete: Closure thông báo kết thúc việc hiển thị quảng cáo
    ///     - failureHandler: Closure thông báo kết thúc việc hiển thị quảng cáo, bắt buộc người dùng phải purchase để tiếp tục sử dụng tính năng
    ///
    ///
    func showRewardAd(from controller: UIViewController,
                      complete: @escaping BFAdComplete,
                      failureHandler: @escaping BFAdFailure)
    {
        let remoteModel = self.remoteModel

        if remoteModel.enableAd != 1 {
            failureHandler()
            return
        }

        if remoteModel.ironAppKey.isEmpty {
            failureHandler()
            return
        }

        rewardComplete = complete
        rewardFailure = failureHandler
        self.controller = controller

        IronSource.setRewardedVideoDelegate(self)

        let isRewardReady = IronSource.hasRewardedVideo()
        if isRewardReady {
            IronSource.showRewardedVideo(with: self.controller!)
        } else {
            DispatchQueue.main.async { [self] in
                self.hud.dismiss(afterDelay: 0.5)
                rewardFailure?()
            }
        }
    }

    func fetchRewardAd() {
        IronSource.hasRewardedVideo()
    }
}

// MARK: - Delegate quảng cáo full

extension AdManager: ISInterstitialDelegate {
    func interstitialDidLoad() {
        DispatchQueue.main.async {
            self.hud.dismiss(afterDelay: 0.5)
        }
        if IronSource.hasInterstitial() == false {
            complete?()
            return
        }

        if let vc = controller {
            IronSource.showInterstitial(with: vc)
        } else {
            complete?()
        }
    }

    func interstitialDidFailToLoadWithError(_ error: Error!) {
        DispatchQueue.main.async {
            self.hud.dismiss(afterDelay: 0.5)
        }
        complete?()
    }

    func interstitialDidOpen() {}

    func interstitialDidClose() {
        complete?()
    }

    func interstitialDidShow() {}

    func interstitialDidFailToShowWithError(_ error: Error!) {
        complete?()
    }

    func didClickInterstitial() {}
}

// MARK: - Delegate quảng cáo reward

extension AdManager: ISRewardedVideoDelegate {
    func rewardedVideoHasChangedAvailability(_ available: Bool) {}

    func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!) {}

    func rewardedVideoDidFailToShowWithError(_ error: Error!) {
        rewardFailure?()
    }

    func rewardedVideoDidOpen() {}

    func rewardedVideoDidClose() {
        rewardComplete?()
    }

    func rewardedVideoDidStart() {}

    func rewardedVideoDidEnd() {
        rewardComplete?()
    }

    func didClickRewardedVideo(_ placementInfo: ISPlacementInfo!) {
        rewardComplete?()
    }
}

// MARK: - Model

class BFRemoteModel: NSObject, Mappable {
    var fullLoop = BFLooper()
    var enableAd: Int = 0
    var ironAppKey: String = ""
    var event: BFRemoteEvent = .init()
    override init() {
        super.init()
    }

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        enableAd <- map["enableAd"]
        ironAppKey <- map["ironAppKey"]
        fullLoop <- map["fullLoop"]
        event <- map["event"]
    }
}

// MARK: - LOOPER

class BFLooper: NSObject, Mappable {
    var start: Int = 1
    var loop: Int = 3

    var count: Int = 0

    override init() {
        super.init()
    }

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        start <- map["start"]
        loop <- map["loop"]
    }

    func validateLoop() -> Bool {
        count += 1
        let isValid = (count == start) || (count % loop == 0)
        return isValid
    }
}

class BFRemoteEvent: NSObject, Mappable {
    private let defaultFlag: String = "bf_default_event"
    private var name: String = ""
    private var eventKey: String = "" // store user default
    private var imagePath: String = "" // Image path
    private var duration: Int = 1800 // Default 30 min

    override init() {
        super.init()
    }

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name <- map["name"]
        imagePath <- map["imagePath"]
        duration <- map["duration"]
        eventKey <- map["eventKey"]
    }

    func setup() {
        print("event key: \(eventKey)")
        let count = UserDefaults.standard.integer(forKey: eventKey)
        // Kiểm tra xem user đã từ lưu countup chưa
        if count > 0 {
            // Nếu user từng lưu countdown thì không làm gì cả
            print("Nếu user từng lưu countdown thì không làm gì cả")
        } else {
            // Nếu user chưa lưu countdouwn thì tạo 1 cái cờ để lưu count up
            print("Nếu user chưa lưu countdouwn thì tạo 1 cái cờ để lưu count up")
            UserDefaults.standard.set(0, forKey: eventKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func checkSaleAvailabe() -> Bool {
        let count = UserDefaults.standard.integer(forKey: eventKey)
        return count <= self.duration
    }

    func incrementCountUp() {
        var count = UserDefaults.standard.integer(forKey: eventKey)
        count += 1
        UserDefaults.standard.set(count, forKey: eventKey)
        UserDefaults.standard.synchronize()
    }

    // Get count down in seconds
    func getEventCountDown() -> Int {
        let count = UserDefaults.standard.integer(forKey: eventKey)
        return duration - count
    }

    func getEventImageURL() -> URL? {
        return URL(string: imagePath)
    }

    func getEventName() -> String {
        return name
    }

    // HH:MM:SS
    func secondsToHoursMinutesSeconds() -> (h: Int, m: Int, s: Int) {
        let seconds = self.getEventCountDown()
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    func getHms() -> String {
        let s = secondsToHoursMinutesSeconds()
        let hour = getStringFrom(seconds: s.h)
        let min = getStringFrom(seconds: s.m)
        let sec = getStringFrom(seconds: s.s)
        return hour + ":" + min + ":" + sec
    }
    
}
