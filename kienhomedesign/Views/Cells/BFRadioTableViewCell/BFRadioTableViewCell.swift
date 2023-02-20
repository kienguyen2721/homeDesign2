//
//  BFRadioTableViewCell.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 16/12/2022.
//

import UIKit

class BFRadioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var radioIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
