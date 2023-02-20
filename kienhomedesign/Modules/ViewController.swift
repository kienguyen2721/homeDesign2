//
//  ViewController.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import SDWebImage
import SwiftNotificationCenter
import SwiftyUserDefaults
import UIKit

class ViewController: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppManager.shared.getUser()
        if DefaultsUtil.isCompleteOnboarding() {
            goToHome()
        }else{
            goOB()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
      
    }
    
    func goOB() {
        let vc = bgob1VC()
        
        self.setRootViewController(vc, animate: true)
    }
    func goToHome() {
        let vc = HomeButtonVC()
        self.setRootViewController(vc, animate: true)

    }
    
    @IBAction func tapPurchase(_ sender: Any) {
        
    }
    
    @IBAction func tapRestore(_ sender: Any) {
        
    }
    
    @IBAction func tapPurchaseLifeTime(_ sender: Any) {
        
    }
    
}
