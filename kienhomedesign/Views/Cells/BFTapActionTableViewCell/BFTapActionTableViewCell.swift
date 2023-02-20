//
//  BFTapActionTableViewCell.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 16/12/2022.
//

import UIKit

class BFTapActionTableViewCell: UITableViewCell {
    
    var onTap: (() -> Void)?
    
    @IBOutlet weak var actionButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func tapActionButton(_ sender: Any) {
        onTap?()
    }
    
}
