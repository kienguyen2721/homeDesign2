//
//  HomeRoomTypeView.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 07/02/2023.
//

import Foundation
import UIKit
protocol HomeDelegate {
    
    func homeRoomTypeViewDidAction(roomBool: Bool)
    func homeRoomTypeViewDidSelect( roomName: String)
//    func tableViewDidSelectedRow(at indexPath: IndexPath)
    
}



class HomeRoomTypeView: BaseView {
    
    @IBOutlet weak var homeTypeView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegateHome: HomeDelegate?
    var action: Bool = false
    
   
    var homeRoomData: [HomeRoomModel] = [
        HomeRoomModel.init(image: "Living room", name: "Living Room", isSellected: false),
        HomeRoomModel.init(image: "Bedroom", name: "Bedroom", isSellected: false),
        HomeRoomModel.init(image: "Kitchen", name: "Kitchen", isSellected: false),
        HomeRoomModel.init(image: "Gaming room", name: "Gaming room", isSellected: false),
        HomeRoomModel.init(image: "Workshop", name: "Workshop", isSellected: false),
        HomeRoomModel.init(image: "Fitness gym", name:  "Fitness gym", isSellected: false),
        HomeRoomModel.init(image: "Home office", name: "Home office", isSellected: false),
        HomeRoomModel.init(image: "Meeting room", name: "Meeting room", isSellected: false),
        HomeRoomModel.init(image: "Coffee shop", name: "Coffee shop", isSellected: false),
        HomeRoomModel.init(image: "Dining room", name: "Dining room", isSellected: false),
        HomeRoomModel.init(image: "Clothing store", name: "Clothing store", isSellected: false),
        HomeRoomModel.init(image: "Study Room", name: "Study Room", isSellected: false),
        HomeRoomModel.init(image: "Restaurant", name: "Restaurant", isSellected: false),
        HomeRoomModel.init(image: "Office", name: "Office", isSellected: false),
        HomeRoomModel.init(image: "Bathroom", name: "Bathroom", isSellected: false),
        HomeRoomModel.init(image: "Hotel lobby", name: "Hotel lobby", isSellected: false),
        HomeRoomModel.init(image: "Hotel room", name: "Hotel room", isSellected: false)
        
    ]
    
    override func commonInit() {
        super.commonInit()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: HomeButtonCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        homeTypeView.backgroundColor = UIColor.init(hexString: "F7F7F7")
  
    }
 
    
}
extension HomeRoomTypeView: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeRoomData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = homeRoomData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(with: HomeButtonCell.self, for: indexPath)
        cell.collectionImageView.image = UIImage(named: item.image)
        cell.nameLabel.text = item.name
        
        
        if item.isSellected == true {
            cell.homeButtonView.layer.borderWidth = 3.0
            cell.homeButtonView.layer.borderColor = UIColor.init(hexString: "005959")?.cgColor
            cell.homeButtonView.backgroundColor = UIColor.init(hexString: "FFFFFF")
        }else{
            cell.homeButtonView.layer.borderWidth = 0
            cell.homeButtonView.backgroundColor = UIColor.init(hexString: "E3E3E3")
        
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newDatas: [HomeRoomModel] = homeRoomData.map { i in
                                    let a = i
                                    a.isSellected = false
                                    return a
                                }
            newDatas[indexPath.row].isSellected = true
            homeRoomData = newDatas
            collectionView.reloadData()
        let itemDele = newDatas[indexPath.row].name
        
        self.delegateHome?.homeRoomTypeViewDidAction(roomBool: action)
        self.delegateHome?.homeRoomTypeViewDidSelect(roomName: itemDele)
        collectionView.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height
        let cellWidth = cellHeight
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

