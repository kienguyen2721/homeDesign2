//
//  HomeButtonCell.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 01/02/2023.
//

import UIKit

class HomeButtonCell: UICollectionViewCell {

    @IBOutlet weak var homeButtonView: UIView!
    @IBOutlet weak var collectionImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
//    var onTapTrans: (() -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        homeButtonView.layer.cornerRadius = 14
        
    }

}
