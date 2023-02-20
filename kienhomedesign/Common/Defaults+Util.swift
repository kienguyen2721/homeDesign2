//
//  Defaults+Util.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Foundation
import SwiftyUserDefaults

// Lưu giá trị vào UserDefault
extension DefaultsKeys {
    /// Số lần mở app
    var applaunch: DefaultsKey<Int> { .init("applaunch", defaultValue: 0) }

    /// Cở kiểm tra xem đã hiển thị xin rate khi có kết quả hay chưa
    var firstRate: DefaultsKey<Bool> { .init("firstRate", defaultValue: false) }

    /// Cờ đếm số lần free trial
    var trialCount: DefaultsKey<Int> { .init("trialCount", defaultValue: 0) }

    /// Cờ kiểm tra xem user hoàn thành xem màn dẫn hay chưa
    var isCompleteOnBoarding: DefaultsKey<Bool> { .init("isCompleteOnBoarding", defaultValue: false) }
    
    /// User info
    var userInfo: DefaultsKey<UserCodable?> { .init("userInfo", defaultValue: nil) }

}

class DefaultsUtil: NSObject {
    /// Cài đặt lại bộ đếm số lần mở app
    static func setDefaultAppLaunch() {
        #if DEBUG
        Defaults[\.applaunch] = 0
        #endif
    }

    /// Tăng bộ đếm số lần mở app
    static func incrementAppLaunch() {
        Defaults[\.applaunch] += 1
    }

    /// Xin rate khi mở app lần thứ 3 - 6 - 9
    /// Hàm này phụ thuộc vào việc đếm số lượng " applaunch " ở trên
    /// Thông thường được gọi ở màn hình " HomeVC ", gọi hàm này trong hàm viewDidLoad , và phải delay 0.5s
    static func canShowAppOpenRate() -> Bool {
        let count = Defaults[\.applaunch]
        if count == 3 || count == 6 || count == 9 {
            return true
        } else {
            return false
        }
    }

    /// Xin rate khi user lưu ảnh,  hoặc ở màn hình result
    static func canShowFirstRate() -> Bool {
        if Defaults[\.firstRate] == false {
            Defaults[\.firstRate] = true
            return true
        } else {
            return false
        }
    }

    /// Kiểm tra xem user còn có thể dùng free được không?
    static func isValidFreeTrial() -> Bool {
        if Defaults[\.trialCount] < K_LIMIT_TRIAL {
            return true
        }
        return false
    }

    /// Tăng số lần sử dụng free trial
    static func inCrementFreeTrial() {
        Defaults[\.trialCount] += 1
    }

    /// Kiểm tra xem user đã xem 3 màn dẫn hay chưa
    static func isCompleteOnboarding() -> Bool {
        return Defaults[\.isCompleteOnBoarding]
    }

    /// Gọi hàm này khi user hoàn thành xem 3 màn dẫn ( có thể gọi là intro ). Thông thường gọi ở màn hình HomeVC, hàm viewDidLoad
    static func completeOnboarding() {
        Defaults[\.isCompleteOnBoarding] = true
    }

    /// Huỷ toàn bộ việc user xem màn dẫn, hàm này chỉ dành cho khi DEBUG
    static func setDefaultCompleteOnboarding() {
        #if DEBUG
        Defaults[\.isCompleteOnBoarding] = false
        #endif
    }
}
