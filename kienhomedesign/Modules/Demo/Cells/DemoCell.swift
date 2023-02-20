//
//  DemoCell.swift
//  mvcsample
//
//  Created by dongnguyen on 21/12/2022.
//

import UIKit

class DemoCell: UITableViewCell {
    
    var onTapDelete: (() -> Void)?
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapDelete(_ sender: Any) {
        onTapDelete?()
    }
    
}
