//
//  VipVC.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 31/01/2023.
//

import UIKit
import FSPagerView
import SnapKit
import SDCAlertView
import SafariServices
import UIView_Shimmer
import SwifterSwift
import Permission
import SwiftNotificationCenter
import SwiftyShadow


class VipVC: BaseVC {
    @IBOutlet var continueInsideView: UIView!
    @IBOutlet var continueView: UIView!
    @IBOutlet var weekImageView: UIImageView!
    @IBOutlet var yearImageView: UIImageView!
    @IBOutlet var saleLabel: UILabel!
    @IBOutlet var saleView: UIView!
    @IBOutlet var weekView: UIView!
    @IBOutlet var yearView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var continueLabel: UILabel!
    var onClose: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        weekImageView.image = UIImage(named: "Oval")

        yearImageView.image = UIImage(named: "Oval")

        settingWeekButton()
        settingYearButton()

        settingContinueButton()

        saleView.backgroundColor = UIColor(gradientStyle: .leftToRight, withFrame: saleView.frame, andColors: [UIColor(hexString: "FF9303"), UIColor(hexString: "FF4300")])

        saleView.cornerRadius = 7
        saleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cancelButton.layer.cornerRadius = cancelButton.height / 2
        yearImageView.image = UIImage(named: "Group 2")
        yearView.backgroundColor = UIColor(hexString: "D5DEE5")
        yearView.borderWidth = 1.0
        yearView.borderColor = UIColor(hexString: "00A2A2")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        continueInsideView.startShimmering()
    }
    
    override func applicationDidBecomeActive() {
        super.applicationDidBecomeActive()
        continueInsideView.startShimmering()
    }

    func settingWeekButton() {
        weekView.layer.cornerRadius = 10
        weekView.backgroundColor = UIColor(hexString: "F7F7F7")
    }

    func settingYearButton() {
        yearView.layer.cornerRadius = 10
        yearView.backgroundColor = UIColor(hexString: "F7F7F7")
    }

    func settingContinueButton() {
        let font = UIFontDescriptor(name: "SFProText-Medium", size: 17.0)
        continueLabel.font = UIFont(descriptor: font, size: 17.0)
        continueView.cornerRadius = 36
        continueInsideView.cornerRadius = 36
        continueInsideView.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: continueInsideView.bounds, andColors: [UIColor(hexString: "00A2A2")!, UIColor(hexString: "007272")!])
        continueView.layer.shadowRadius = 3
        continueView.layer.shadowOpacity = 0.6
        continueView.layer.shadowColor = UIColor.black.cgColor
        continueView.layer.shadowOffset = CGSize.init(width: 3, height: 3)
        continueView.generateOuterShadow()

       

        
        

        
    }

    @IBAction func pressWeekButton(_ sender: Any) {
        weekImageView.image = UIImage(named: "Group 2")
        weekView.backgroundColor = UIColor(hexString: "D5DEE5")
        weekView.borderWidth = 1.0
        weekView.borderColor = UIColor(hexString: "00A2A2")
        yearImageView.image = UIImage(named: "Oval")
        yearView.backgroundColor = UIColor(hexString: "F7F7F7")
        yearView.borderWidth = 0
      
    }

    @IBAction func pressYearButton(_ sender: Any) {
        yearImageView.image = UIImage(named: "Group 2")
        yearView.backgroundColor = UIColor(hexString: "D5DEE5")
        yearView.borderWidth = 1.0
        yearView.borderColor = UIColor(hexString: "00A2A2")
        weekImageView.image = UIImage(named: "Oval")
        weekView.backgroundColor = UIColor(hexString: "F7F7F7")
        weekView.borderWidth = 0
        
    }
    @IBAction func pressCancelButton(_ sender: Any) {
        if DefaultsUtil.isCompleteOnboarding() {
            self.dismiss(animated: true)
//            self.onClose?()
        } else {
            let vc = HomeButtonVC()
            self.setRootViewController(vc)
//            self.onClose?()
        }

    }

    @IBAction func pressContinueButton(_ sender: Any) {
        
        
    }
}
