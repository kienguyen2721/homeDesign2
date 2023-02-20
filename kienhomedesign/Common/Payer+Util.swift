//
//  Payer+Util.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Foundation
import StoreKit
import SwiftNotificationCenter
import SwiftyStoreKit
import SwiftyUserDefaults
import UIKit

public typealias PayerComplete = () -> Void
public typealias PayerCompletion<T, U> = (T, U) -> Void
public typealias PayerProducts = (Set<SKProduct>) -> Void

extension DefaultsKeys {
    var isPurchased: DefaultsKey<Bool> { .init("isPurchased", defaultValue: false) }
    var isAllowedToFetch: DefaultsKey<Bool> { .init("isAllowedToFetch", defaultValue: false) }
}

public protocol Payerable {
    func payerableDidPurchase()
}

open class Payer: NSObject {
    private var subscriptions: [String] = []
    private var appleSecretKey: String = ""
    private var services: AppleReceiptValidator.VerifyReceiptURLType = .production
    
    public static let shared = Payer()
    
    public func config(subscriptions: [String],
                       services: AppleReceiptValidator.VerifyReceiptURLType = .production,
                       appleSecretKey: String)
    {
        self.subscriptions = subscriptions
        self.services = services
        self.appleSecretKey = appleSecretKey
    }
    
    private func isSetAllowToFetch() -> Bool {
        return Defaults[\.isAllowedToFetch]
    }
    
    private func setAllowedToFetch() {
        Defaults[\.isAllowedToFetch] = true
    }
    
    public var isPurchased: Bool {
        return Defaults[\.isPurchased]
    }
}

public extension Payer {
    /// Trả phí 1 subscription
    func purchase(product id: String, completion: @escaping PayerCompletion<Bool, String?>) {
        SwiftyStoreKit.purchaseProduct(id,
                                       quantity: 1,
                                       atomically: true) { result in
            switch result {
            case .success:
                print("Purchase success")
                self.setPurchased()
                self.setAllowedToFetch()
                completion(true, nil)
            case .error(let error):
                switch error.code {
                case .unknown:
                    completion(false, "Purchase fail, please try again!")
                case .clientInvalid:
                    completion(false, "Not allowed to make the payment")
                case .paymentCancelled:
                    completion(false, "Payment cancelled")
                case .paymentInvalid:
                    completion(false, "The purchase identifier was invalid")
                case .paymentNotAllowed:
                    completion(false, "The device is not allowed to make the payment")
                case .storeProductNotAvailable:
                    completion(false, "The product is not available in the current storefront")
                case .cloudServicePermissionDenied:
                    completion(false, "Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed:
                    completion(false, "Could not connect to the network")
                case .cloudServiceRevoked:
                    completion(false, "User has revoked permission to use this cloud service")
                default:
                    completion(false, (error as NSError).localizedDescription)
                }
            }
        }
    }
    
    /// Hàm hỗ trợ tính năng mua gem
    func purchaseConsumable(product id: String, completion: @escaping PayerCompletion<Bool, String?>) {
        SwiftyStoreKit.purchaseProduct(id,
                                       quantity: 1,
                                       atomically: true) { result in
            switch result {
            case .success:
                print("Purchase success")
                completion(true, nil)
            case .error(let error):
                switch error.code {
                case .unknown:
                    completion(false, "Purchase fail, please try again!")
                case .clientInvalid:
                    completion(false, "Not allowed to make the payment")
                case .paymentCancelled:
                    completion(false, "Payment cancelled")
                case .paymentInvalid:
                    completion(false, "The purchase identifier was invalid")
                case .paymentNotAllowed:
                    completion(false, "The device is not allowed to make the payment")
                case .storeProductNotAvailable:
                    completion(false, "The product is not available in the current storefront")
                case .cloudServicePermissionDenied:
                    completion(false, "Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed:
                    completion(false, "Could not connect to the network")
                case .cloudServiceRevoked:
                    completion(false, "User has revoked permission to use this cloud service")
                default:
                    completion(false, (error as NSError).localizedDescription)
                }
            }
        }
    }
    
    /// Khôi phục gói subscription đã mua trước đây trên thiết bị mới
    func restore(completion: @escaping PayerCompletion<Bool, String?>) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoredPurchases.count > 0 {
                print("Restore Success: \(results.restoredPurchases)")
                let lifetimes = results.restoredPurchases.filter { $0.productId == K_PRODUCT_LIFE_TIME }
                if lifetimes.count > 0 {
                    self.setPurchased()
                    self.setAllowedToFetch()
                    completion(true, nil)
                }
                else {
                    self.verifySubscriptions { isSuccess, errorMsg in
                        if isSuccess {
                            self.setPurchased()
                            self.setAllowedToFetch()
                            completion(true, nil)
                        }
                        else {
                            completion(false, errorMsg)
                        }
                    }
                }
            }
            else {
                completion(false, "Nothing to restore")
            }
        }
    }
    
    /// Kiểm tra xem user còn pro không, gọi hàm này mỗi khi vào app
    func verifySubscriptions(completion: @escaping PayerCompletion<Bool, String?>) {
        if self.subscriptions.isEmpty {
            fatalError("List subscription must not empty. Please add use method `configs` to set list subscription")
        }
        let appleValidator = AppleReceiptValidator(service: self.services,
                                                   sharedSecret: self.appleSecretKey)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productIds = Set(self.subscriptions)
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: productIds, inReceipt: receipt)
                switch purchaseResult {
                case .purchased:
                    completion(true, nil)
                case .expired(let expiryDate, _):
                    let msg = "Products are expired since \(expiryDate), please purchase again!"
                    completion(false, msg)
                case .notPurchased:
                    let msg = "The user has never purchased \(productIds)!"
                    log.debug(msg, context: msg)
                    completion(false, "Purchase fail, please try again!")
                }
            case .error(let error):
                let msg = "Receipt verification failed: \(error)"
                log.debug(msg, context: msg)
                completion(false, "Purchase fail, please try again!")
            }
        }
    }
    
    /// Lấy giá của gói IAP
    func getInfoSubscriptions(completion: @escaping (Set<SKProduct>) -> Void) {
        SwiftyStoreKit.retrieveProductsInfo(Set(self.subscriptions)) { result in
            if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            if let error = result.error {
                print("error = \(error.localizedDescription)")
            }
            completion(result.retrievedProducts)
        }
    }
    
    /// Hoàn thành quá trình kiểm tra ban đầu
    func completeTransactions(completion: @escaping PayerComplete) {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                case .failed, .purchasing, .deferred:
                    break
                @unknown default:
                    break
                }
            }
        }
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        if self.isSetAllowToFetch() {
            self.verifySubscriptions { isSuccess, _ in
                if isSuccess {
                    self.setPurchased()
                    self.setAllowedToFetch()
                    dispatchGroup.leave()
                }
                else {
                    Defaults[\.isPurchased] = false
                    dispatchGroup.leave()
                }
            }
        }
        else {
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            print("Transactions complete 👍")
            completion()
        }
    }
    
    func setPurchased(value: Bool = true) {
        Defaults[\.isPurchased] = value
        Broadcaster.notify(Payerable.self) {
            $0.payerableDidPurchase()
        }
    }
}
