//
//  HomeStyleView.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 07/02/2023.
//

import Foundation
protocol HomeStyleDelegate {
    func homeStyleViewDidAction(roomBool: Bool)
    func homeStyleViewDidSellect(roomStyle: String)
}

class HomeStyleView: BaseView {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var homeRoomView: UIView!
    
    
    var galleryData: [HomeStyleModel] = [
        HomeStyleModel(image: "room_demo1", name: "christmas", isTapped: false),
        HomeStyleModel(image: "room_demo2", name: "modern", isTapped: false),
        HomeStyleModel(image: "room_demo3", name: "minimalist", isTapped: false),
        HomeStyleModel(image: "room_demo4", name: "zen", isTapped: false),
        HomeStyleModel(image: "room_demo5", name: "midcentury modern", isTapped: false),
        HomeStyleModel(image: "room_demo6", name: "industrial", isTapped: false),
        HomeStyleModel(image: "room_demo7", name: "cottagecore", isTapped: false),
        HomeStyleModel(image: "room_demo8", name: "contemporary", isTapped: false),
        HomeStyleModel(image: "room_demo9", name: "bohemian", isTapped: false),
        HomeStyleModel(image: "room_demo10", name: "scandinavian", isTapped: false)
    ]

    var delegateStyle: HomeStyleDelegate?
    var action: Bool = true
    
    override func commonInit() {
        super.commonInit()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: HomeImageCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        collectionView.backgroundColor = UIColor(hexString: "F7F7F7")
        homeRoomView.backgroundColor = UIColor(hexString: "F7F7F7")
    }
    
    @IBAction func pressXButton(_ sender: Any) {
        delegateStyle?.homeStyleViewDidAction(roomBool: action)
        collectionView.reloadData()
    }
}

extension HomeStyleView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = galleryData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(with: HomeImageCell.self, for: indexPath)
        cell.collectionImageView.image = UIImage(named: item.image)
        cell.contentLabel.text = item.name
        if item.isTapped == true {
            cell.collectionImageView.layer.borderWidth = 3.0
            cell.collectionImageView.layer.borderColor = UIColor.black.cgColor
        }else {
            cell.collectionImageView.layer.borderWidth = 0
        }
        
        cell.layer.cornerRadius = 14
        cell.backgroundColor = UIColor(hexString: "F7F7F7")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newDatas: [HomeStyleModel] = galleryData.map { i in
            let a = i
            a.isTapped = false
            return a
        }
        newDatas[indexPath.row].isTapped = true
        galleryData = newDatas
        collectionView.reloadData()
        
        
        self.delegateStyle?.homeStyleViewDidSellect(roomStyle: newDatas[indexPath.row].name)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height
//        let cellWidth = (collectionView.bounds.width - 20 - (cellSpace * 1) ) / 3
        let cellWidth = cellHeight / 132 * 112
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}
