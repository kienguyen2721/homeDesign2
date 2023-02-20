//
//  BFSwitchTableViewCell.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 16/12/2022.
//

import UIKit

class BFSwitchTableViewCell: UITableViewCell {
    
    var onChange: ((Bool) -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var switchButton: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeSwitchButton(_ sender: Any) {
        self.onChange?(switchButton.isOn)
    }
    
}
