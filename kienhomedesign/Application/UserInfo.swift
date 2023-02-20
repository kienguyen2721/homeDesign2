//
//  UserInfo.swift
//  mvcsample
//
//  Created by dongnguyen on 22/12/2022.
//

import Foundation
import SwiftyUserDefaults

// Bây h sẽ lưu tất cả các key trong user default vào 1 object duy nhất
final class UserCodable: NSObject, Codable {
    var uid: String = UUID().uuidString
    var isPro: Bool = false
    var createAt: Date = Date()
    var appLaunch: Int = 0
    var trialCount: Int = 0
    
    init(isPro: Bool, appLaunch: Int, trialCount: Int) {
        self.isPro = isPro
        self.appLaunch = appLaunch
        self.trialCount = trialCount
    }
    
}

extension UserCodable: DefaultsSerializable {
    static var _defaults: DefaultsCodableBridge<UserCodable>
    { return DefaultsCodableBridge<UserCodable>() }
    
    static var _defaultsArray: DefaultsCodableBridge<[UserCodable]>
    { return  DefaultsCodableBridge<[UserCodable]>()}
    
}
