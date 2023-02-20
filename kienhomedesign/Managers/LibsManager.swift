//
//  LibsManager.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Firebase
import Foundation
import SwiftyBeaver

class LibsManager: NSObject {
    /// The default singleton instance.
    static let shared = LibsManager()

    /// Mỗi lần vào app đều gọi hàm này
    func setupLibs() {
        let libsManager = LibsManager.shared
        /// Cài đặt logger
        libsManager.setupLogger()
        /// Cài đặt firebase
        libsManager.setupFirebase()
        
        /// Cài đặt cho việc xin rate
        libsManager.setupRate()
        
        /// Cài đặt để gửi log lên App Metrica
        libsManager.setupAppMetrica()
        
        /// Cài đặt để hoàn thành các giao dịch mua, cái này bắt buộc sử dụng khi có IAP
        libsManager.setupPayer()
                
        /// Mỗi lần vào app + 1 để đếm số lần mở app, phục vụ cho xin rate mỗi lần mở app thứ 3 - 6 - 9
        DefaultsUtil.incrementAppLaunch()
    }
    
    private func setupLogger() {
        let console = ConsoleDestination() // log to Xcode Console
        console.format = "$DHH:mm:ss$d $N.$F:$l $L: $M"
        log.addDestination(console)
    }

    private func setupFirebase() {
        FirebaseApp.configure()
        AdManager.shared.config(complete: {
//            AdManager.shared.remoteModel.event.setup()
//            SaleManager.shared.startTimer()
        })
    }

    private func setupRate() {
        RateManager.shared.config()
    }
    
    private func setupAppMetrica() {
        AppMetricaManager.initializingSDK()
    }
    
    // Chỉ có subscription mới được thêm vào đây
    private func setupPayer() {
        // Main products
        let products = [K_PRODUCT_WEEKLY,
                        K_PRODUCT_MONTHLY,
                        K_PRODUCT_YEARLY]
        
        // Sale products
        let saleProducts = [K_PRODUCT_SALE_WEEKLY,
                            K_PRODUCT_SALE_MONTHLY,
                            K_PRODUCT_SALE_YEARLY]
        
        let subs = products + saleProducts
        
        let filterd = subs.filter { !$0.isEmpty }
        if filterd.isEmpty {
            log.debug("Ứng dụng không có bán gói sub nào.")
        } else {
            log.debug("Danh sách gói sub: \(filterd)")
        }
        
        Payer.shared.config(subscriptions: filterd, appleSecretKey: K_APPLE_SECRET)
        Payer.shared.completeTransactions { /* Complete */ }
    }
}
