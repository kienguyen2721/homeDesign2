//
//  HomeImageCell.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 06/02/2023.
//

import UIKit

class HomeImageCell: UICollectionViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var collectionImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionImageView.layer.cornerRadius = 14
        homeView.backgroundColor = UIColor.init(hexString: "F7F7F7")
    }

}
