//
//  ResultVC.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 01/02/2023.
//

import UIKit
import Permission
import SwiftNotificationCenter
import SDCAlertView
import SDWebImage
import UIView_Shimmer
import SwiftyShadow


class ResultVC: BaseVC{
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var allView: UIView!
    @IBOutlet weak var genarateView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var resultImageView: UIImageView!
    var imageResult: UIImage?
    
    var pictureResult: UIImage?
    var roomResult: String = ""
    var styleResult: String = ""
    var netUseCase: HomesUseCase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allView.backgroundColor = UIColor(hexString: "F7F7F7")
        resultView.backgroundColor = UIColor(hexString: "FFFFFF")
        resultView.layer.cornerRadius = 20
        resultView.addShadow(ofColor: UIColor(hexString: "000000"), radius: 8, offset: CGSize(width: 0, height: 0), opacity: 0.25)

//        self.navigationController?.isNavigationBarHidden = false

        resultImageView.image = imageResult
        resultImageView.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        settingHomeView()
        settingSaveView()
        settingShareView()
        settingGenerateView()
       
        netUseCase = NetUseCaseProvider().makeHomesUseCase()
    }
   
    func callAPIResult(image: UIImage,room: String,style: String) {
        netUseCase?.getAll(image: image, room: room, style: style, complete: { model in
            log.debug(model?.getFullPath())
            let url = URL(string: model?.getFullPath())
            if model == nil {
                log.debug("error")
            }else {
                SDWebImageManager.shared.loadImage(with: url, options: .continueInBackground) { (receivedSize, expectedSize, url) in
                            } completed: { (downloadImage, data, Error, SDImageCacheType, true, url) in
                                self.hud.dismiss(animated: true)
                                if downloadImage != nil {
                                    self.imageResult = downloadImage
                                    self.resultImageView.image = self.imageResult
                                } else {
                                    print("err")
                                }
                            }
            }
        }
        )

    }


    // setting nut genarate
    func settingGenerateView() {
        genarateView.layer.cornerRadius = 16
        genarateView.backgroundColor = UIColor(hexString: "00A2A2")
        genarateView.layer.shadowRadius = 3
        genarateView.layer.shadowOpacity = 0.6
        genarateView.layer.shadowColor = UIColor.black.cgColor
        genarateView.layer.shadowOffset = CGSize.init(width: 3, height: 3)
        genarateView.generateOuterShadow()
        
//        UIColor.init(gradientStyle: .leftToRight, withFrame: genarateView.frame, andColors: [UIColor.init(hexString: "00A2A2"),UIColor.init(hexString: "007272")])
    }
    
    // setting nut save
    func settingSaveView() {
        saveView.layer.cornerRadius = 12
        saveView.backgroundColor = UIColor(hexString: "EEEEEE")
    }
    
    // setting nut home
    func settingHomeView() {
        homeView.layer.cornerRadius = 12
        homeView.backgroundColor = UIColor(hexString: "EEEEEE")
    }
    
    // setting nut share
    func settingShareView() {
        shareView.layer.cornerRadius = 12
        shareView.backgroundColor = UIColor(hexString: "EEEEEE")
    }
    
    // func save Image
    
    func save() {
            DNPermission.checkPhoto { success in
               
                    if success {
                        UIImageWriteToSavedPhotosAlbum(self.imageResult!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                    }
                
            }
        }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
            // we got back an error!
               let alert = AlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .actionSheet)
                alert.addAction(AlertAction(title: "OK", style: .normal, handler:  { act in
    //               SwiftRater.rateApp(host: self)
               }))
               alert.present()
            } else {
                let alert = AlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
               alert.addAction(AlertAction(title: "OK", style: .normal, handler:  { act in
    //               SwiftRater.rateApp(host: self)
               }))
               alert.present()
            }
        }
    
 
    @IBAction func pressHomeButton(_ sender: Any) {
       
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // nut genarate
    @IBAction func pressGenarateButton(_ sender: Any) {
        log.debug(roomResult)
        log.debug(styleResult)
        if let image = pictureResult {
            callAPIResult(image: image, room: roomResult, style: styleResult)
            self.hud.show(in: allView, animated: true)
        }
    }
    @IBAction func saveImage(_ sender: Any) {
        save()
    }

   
}

