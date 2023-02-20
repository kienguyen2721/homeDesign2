//
//  AnalyticsManager.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 28/11/2022.
//

import FirebaseAnalytics
import Foundation

let analytics = Analytics()

//Example - Gọi cái này khi phát sinh action
//analytics.log(.homeTapSettings(someValue: "OKe"))

enum AnalyticsEventType {
    case homeTapGenerate
    case homeTapSettings(someValue: String)
}

extension AnalyticsEventType {
    func name() -> String {
        switch self {
        case .homeTapGenerate:
            return "home_tap_generate"
        case .homeTapSettings(let someValue):
            return "home_tap_settings"
        }
    }

    func parameters() -> [String: Any]? {
        var param: [String: Any] = [:]
        param["isVip"] = Payer.shared.isPurchased ? 1 : 0
        switch self {
        case .homeTapGenerate:
            break
        case .homeTapSettings(let someValue):
            param["someValue"] = someValue
        default:
            break
        }
        return param
    }
}

class Analytics {
    func log(_ event: AnalyticsEventType) {
        let name = event.name()
        let parameters = event.parameters()
        FirebaseAnalytics.Analytics.logEvent(name, parameters: parameters)
    }

    func set(_ userProperty: AnalyticsUserEventType) {
        let name = userProperty.name()
        let value = userProperty.value()
        FirebaseAnalytics.Analytics.setUserProperty("\(value)", forName: name)
    }
}

// Khi cần tracking user info thì sử dụng những cái này, thông thường thì k cần
enum AnalyticsUserEventType {
    case name(value: String)
    case email(value: String)
    case colorTheme(value: String)
    case adsEnabled(value: Bool)
    case nightMode(value: Bool)
}

extension AnalyticsUserEventType {
    func name() -> String {
        switch self {
        case .name: return "name"
        case .email: return "email"
        case .adsEnabled: return "ads_enabled"
        case .nightMode: return "night_mode_enabled"
        case .colorTheme: return "color_theme"
        }
    }

    func value() -> Any {
        switch self {
        case .name(let value),
             .email(let value),
             .colorTheme(let value):
            return value
        case .adsEnabled(let value),
             .nightMode(let value):
            return value
        }
    }
}
