//
//  SettingVC.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 04/02/2023.
//

import UIKit


class DataCollectionModel {
    var image: String = ""
    var name: String = ""
    var isSellected: Bool = false
    
    init(image: String,name: String,isSellected: Bool) {
        self.image = image
        self.name = name
        self.isSellected = isSellected
    }
}

class SettingVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var settingData: [DataCollectionModel] =
    [
        DataCollectionModel.init(image: "star", name: "Rate us", isSellected: false),
        DataCollectionModel.init(image: "contact-mail", name: "Contact us", isSellected: false),
        DataCollectionModel.init(image: "info", name: "About us", isSellected: false),
        DataCollectionModel.init(image: "security", name: "Privacy Policy", isSellected: false),
        DataCollectionModel.init(image: "accept", name: "Terms of Use", isSellected: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SettingCell.self)
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 52, bottom: 0, right: 52)
    }
    @IBAction func pressBackButton(_ sender: Any){
       
        self.navigationController?.popViewController(animated: true)
    }


    

}
extension SettingVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = settingData[indexPath.row]
        let cell = tableView.dequeueReusableCell(with: SettingCell.self, for: indexPath )
        cell.iconSettingImageView.image = UIImage(named: item.image)
        cell.txtSettingLabel.text = item.name

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
