//
//  RateManager.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Foundation
import SwiftRater

class RateManager: NSObject {
    static let shared = RateManager()

    func config() {
        SwiftRater.daysUntilPrompt = 7
        SwiftRater.usesUntilPrompt = 10
        SwiftRater.significantUsesUntilPrompt = 3
        SwiftRater.daysBeforeReminding = 1
        SwiftRater.showLaterButton = true
        SwiftRater.appID = K_APP_ID
        #if DEBUG
        SwiftRater.debugMode = true // need to set false when submitting to AppStore!!
        #endif
        SwiftRater.appLaunched()
    }

    func requestRate() {}
}
