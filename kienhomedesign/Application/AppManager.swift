//
//  AppManager.swift
//  mvcsample
//
//  Created by dongnguyen on 22/12/2022.
//

import Foundation
import SwifterSwift
import SwiftyUserDefaults
import StoreKit

final class AppManager: NSObject {
    static let shared = AppManager()
    
    // Không cho phép ghi đè user info từ bên ngoài
    var user: UserCodable?
    
    private lazy var defaultUser = UserCodable(isPro: false, appLaunch: 0, trialCount: 0)
    
    func start() {
        // Lấy thông tin user từ UserDefault
        user = Defaults[\.userInfo]
        
        // Kiểm tra thông tin user
        if user != nil {
            // Nếu có user thì tăng app launch lên 1
            user?.appLaunch += 1
            store()
        } else {
            // Nếu chưa có thì cài mặc định app launch = 1 và gán lại
            user = defaultUser
            user?.appLaunch += 1
            store()
        }
    }
    
    private func store() {
        Defaults[\.userInfo] = user
    }
    
//    func askRateOpenApp() {
//        guard let u = user else { return }
//        if u.appLaunch == 3 || u.appLaunch == 6 || u.appLaunch == 9 {
//            SKStoreReviewController.requestReview(in: <#T##UIWindowScene#>)
//        }
//    }
//    
    func getUser() {
        log.debug("Số lần mở app: \(user.unwrapped(or: defaultUser).appLaunch)")
    }
}
