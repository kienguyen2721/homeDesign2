//
//  BaseVC.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Foundation
import JGProgressHUD
import SDCAlertView
import StoreKit
import SwiftRater
import UIKit

class BaseVC: UIViewController {
    let hud = JGProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Cấu hình loading view
        hud.textLabel.text = "Loading"
        hud.style = .dark
        /// Cách sử dụng:
        /// hud.show(in: self.view)
        /// hud.dismiss(afterDelay: 3.0)
    }

    deinit {
        print("\(type(of: self)): Deinited")
    }

    // Controller nào cần bắt sự kiện UIApplication.didBecomeActiveNotification thì gọi vào viewDidLoad
    func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }

    // Khi ấn backButton cần gọi hàm này để huỷ Observer NotificationCenter, nếu không gọi, app sẽ dễ bị leak memory
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    // Override hàm này ở các subcontroller để bắt sự kiện UIApplication.didBecomeActiveNotification
    @objc func applicationDidBecomeActive() {
        // Code
    }

    func requestInAppReview() {
        SKStoreReviewController.requestReview()
    }
}

// MARK: - Ad

extension BaseVC {
    ///  Hiển thị quảng cáo xen giữa
    func showFull(comlete: @escaping BFComplete) {
        if Payer.shared.isPurchased {
            comlete()
        } else {
            AdManager.shared.showFull(from: self, complete: comlete)
        }
    }

    /// Hiển thị quảng cáo xem video để nhận thưởng
    func showReward(complete: @escaping BFComplete, failure: @escaping BFFailure) {
        if Payer.shared.isPurchased {
            complete()
        } else {
            AdManager.shared.showRewardAd(from: self, complete: complete, failureHandler: failure)
        }
    }
    func setRootViewController(_ vc: UIViewController, animate: Bool = true) {
        guard animate, let window = appDelegate.window else {
            appDelegate.window!.rootViewController = vc
            appDelegate.window!.makeKeyAndVisible()
            return
        }
        
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

// MARK: - In-App Review

extension BaseVC {
    /// Yêu cầu user rate ứng dụng
    func requestReview() {
        SKStoreReviewController.requestReview()
    }

    /// Hàm hiển thị xin rate trong settings
    /// Chỉ sử dụng hàm này trong màn hình SettingVC
    func alertRequestReview() {
        SwiftRater.rateApp(host: self)
    }
}

// MARK: - Network connections

extension BaseVC {
    func checkConnectionStatus() -> Bool {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            return false
        case .online(.wwan):
            print("Connected via WWAN")
            return true
        case .online(.wiFi):
            print("Connected via WiFi")
            return true
        }
    }
}
