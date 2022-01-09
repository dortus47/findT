//
//  SetttingsTableViewController.swift
//  findT
//
//  Created by 장은석 on 2021/12/29.
//

import UIKit
import SnapKit
import MapKit

class SetttingsTableViewController: UITableViewController {
    
    
    let sections = ["title", "options"]
    let tempTitle = ["임시1", "임시2", "임시3", "임시4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return tempTitle.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // title
        if indexPath.section == 0 {
            let cell = UITableViewCell()
            let titleImage = UIImageView(image: UIImage(named: "testImage.jpg"))
            
            cell.backgroundColor = .brown
            titleImage.backgroundColor = .red
            cell.contentView.backgroundColor = .blue
            cell.contentView.addSubview(titleImage)
            titleImage.snp.makeConstraints { make in
                make.height.width.equalTo(self.view.frame.height / 5)
                make.left.equalToSuperview().offset(10)
            }
//            titleImage.layer.cornerRadius = 100
            titleImage.layer.masksToBounds = true
//            titleImage.layer.borderWidth = 1
            titleImage.clipsToBounds = true
            
            
            cell.contentView.snp.makeConstraints { make in
                make.height.equalTo(titleImage.snp.height)
            }
            return cell
        }
        
        // options
        else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let cell = SettingTableViewCell()
                cell.setData(name: "sounds")
                return cell
            case 1:
                let cell = SettingTableViewCell()
                cell.setData(name: "sounds")
                return cell
            default:
                let cell = UITableViewCell()
                cell.contentView.backgroundColor = .cyan
                return cell
            }
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
}
