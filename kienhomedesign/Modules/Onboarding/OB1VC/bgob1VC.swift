//
//  bgob1VC.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 30/01/2023.
//

import UIKit

class bgob1VC: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var obLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.layer.cornerRadius = 15
//        newButton.layer.borderWidth = 1
//        newButton.layer.borderColor = UIColor.init(hexString: "E9B92D")?.cgColor
        nextButton.backgroundColor =  UIColor.init(hexString: "00A2A2")
        
        nextButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor
        nextButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        nextButton.layer.shadowOpacity = 6.0
        
        

        
        let font = UIFontDescriptor(name: "SFProText Medium", size: 19.0)
        obLabel.font = UIFont(descriptor: font, size: 22.0)
        
//        obLabel.font = R.
    }
    @IBAction func nextOnTapButton(){
        let vc = OB2VC()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }



}
//newButton.backgroundColor = UIColor.init(gradientStyle: .t, withFrame: newButton.frame, andColors: [UIColor.init(hexString: "00A2A2")])
//FF9303
