//
//  HomeButtonVC.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 01/02/2023.
//
import UIKit
import SwiftUI
import SDWebImage
import SwiftNotificationCenter
import SDCAlertView
import UIView_Shimmer

protocol ResultHomeDelegate {
    func resultDidImage(image: UIImage?)
}

class HomeButtonVC: BaseVC {
    @IBOutlet var allView: UIView!
    @IBOutlet var homeView: UIView!
    @IBOutlet var uploadView: UIView!
    @IBOutlet var vipHome: UIView!
   
    @IBOutlet var homeImageView: UIImageView!
    @IBOutlet var footerView: HomeRoomTypeView!
    @IBOutlet var homeStyleView: HomeStyleView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var appNameLabel: UILabel!
    
    var cellSpace: CGFloat = 16
    var viewHaveIcon: Bool = true
    var netUseCase: HomesUseCase?
    var delegateResult: ResultHomeDelegate?
    var tempOriginImage: UIImage?
    var tempRoomName: String = ""
    var tempRoomStyle: String = ""
    let randomImage: [String] = ["Image01","Image02","Image03","Image04","Image05","Image06"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        DefaultsUtil.completeOnboarding()
        homeImageView.image = UIImage(named: "IMG_0915")
        
        settingView()
        settingStackView()
        settingVipView()
        animateDidLoad()
        footerView.delegateHome = self
        homeStyleView.delegateStyle = self
        footerView.backgroundColor = UIColor(hexString: "F7F7F7")
        homeStyleView.backgroundColor = UIColor(hexString: "F7F7F7")
        homeImageView.layer.cornerRadius = 20
//        homeImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let font = UIFontDescriptor(name: "BalooBhaijaan-Regular", size: 36.0)
        appNameLabel.font = UIFont(descriptor: font, size: 36.0)
        
        
        netUseCase = NetUseCaseProvider().makeHomesUseCase()

        self.delegateResult?.resultDidImage(image: tempOriginImage)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vipHome.startShimmering()
        animateDidLoad()
        
    }
    
    override func applicationDidBecomeActive() {
        super.applicationDidBecomeActive()
        vipHome.startShimmering()
    }
    func animateDidLoad(){
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.homeStyleView.transform = self.homeStyleView.transform.translatedBy(x: 0, y: 400)
            
        }
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            //            self.txtLabel.transform = self.txtLabel.transform.translatedBy(x: 0, y: 400)
            self.footerView.alpha = 1
        }
    }
    func callApiHome(image: UIImage,room: String,style: String) {
        netUseCase?.getAll(image: image, room: room, style: style, complete: { model in
            log.debug(model?.getFullPath())

            let url = URL(string: model?.getFullPath())
            if model == nil {
                log.debug("error")
            }else {
                
                SDWebImageManager.shared.loadImage(with: url, options: .continueInBackground) { (receivedSize, expectedSize, url) in
                            } completed: { (downloadImage, data, Error, SDImageCacheType, true, url) in
                                if downloadImage != nil {
                                    self.hud.dismiss(animated: true)
                                    let vc = ResultVC()
                                    vc.imageResult = downloadImage
                                    vc.styleResult = style
                                    vc.roomResult = room
                                    vc.pictureResult = self.tempOriginImage
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    
                                } else {
                                    print("err")
                                }
                            }
            }
        })
    }


    func settingVipView() {
//        vipHome.startShimmering()
        vipHome.backgroundColor = UIColor.init(gradientStyle: .leftToRight, withFrame: vipHome.frame, andColors: [UIColor.init(hexString: "FF9303"),UIColor.init(hexString: "FF4300")])
        vipHome.layer.cornerRadius = 10
    }
    
    func settingStackView() {
        stackView.backgroundColor = UIColor(hexString: "FFFFFF")
        stackView.layer.cornerRadius = 15
        stackView.alpha = 0.9
        stackView.addShadow(ofColor: UIColor(hexString: "000000"), radius: 8, offset: CGSize(width: 0, height: 0), opacity: 0.25)
    }
    
    func settingView() {
        allView.backgroundColor = UIColor(hexString: "F7F7F7")
        homeView.backgroundColor = UIColor(hexString: "F7F7F7")
        uploadView.backgroundColor = UIColor(hexString: "FFFFFF")
        uploadView.layer.cornerRadius = 20
        uploadView.addShadow(ofColor: UIColor(hexString: "000000"), radius: 8, offset: CGSize(width: 0, height: 0), opacity: 0.25)
    }

    func settingAnimate() {
        if viewHaveIcon == false {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.footerView.alpha = 0
            }
            
            UIView.animate(withDuration: 0.2, delay: 0.3) {
                self.homeStyleView.transform = .identity
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.homeStyleView.transform = self.homeStyleView.transform.translatedBy(x: 0, y: 400)
            }
            UIView.animate(withDuration: 0.2, delay: 0.3) {
                //            self.txtLabel.transform = self.txtLabel.transform.translatedBy(x: 0, y: 400)
                self.footerView.alpha = 1
            }
        }
    }

    @IBAction func pressVipButton(_ sender: Any) {
        let vc = VipVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)

    }

    @IBAction func pressSettingButton(_ sender: Any) {
        let vc = SettingVC()
        
        navigationController?.pushViewController(vc, animated: true)
    }
   
    @IBAction func pressRandomButton(_ sender: Any) {
        let randomImg = randomImage.randomElement()
        homeImageView.image = UIImage(named: randomImg!)
        tempOriginImage = UIImage(named: randomImg!)
    }
    
    func showResultVC() {
        let vc = ResultVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeButtonVC: HomeDelegate {
    func homeRoomTypeViewDidAction(roomBool: Bool) {
        viewHaveIcon = roomBool
        settingAnimate()
    }
    
    func homeRoomTypeViewDidSelect(roomName: String) {
        tempRoomName = roomName
        
    }
}

extension HomeButtonVC: HomeStyleDelegate {
    func homeStyleViewDidAction(roomBool: Bool) {
        viewHaveIcon = roomBool
        settingAnimate()
    }
    
    func homeStyleViewDidSellect(roomStyle: String) {
        tempRoomStyle = roomStyle
        UIView.animate(withDuration: 0, delay: 0) {
            self.hud.show(in: self.allView, animated: true)
        }

        if let image = tempOriginImage {
            callApiHome(image: image, room: tempRoomName, style: tempRoomStyle)

        }else {
            let alert = AlertController(title: "Opp!", message: "Our server is having problems, please try again later.", preferredStyle: .alert)
           alert.addAction(AlertAction(title: "OK", style: .normal, handler:  { act in
            self.hud.dismiss(animated: true)
               
           }))
           alert.present()
        }
        
    }
    
   
}

extension HomeButtonVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBAction func pressLibrsButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func pressCameraButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let tmpImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        homeImageView.image = tmpImage
        tempOriginImage = tmpImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("user cancel")
    }
}
