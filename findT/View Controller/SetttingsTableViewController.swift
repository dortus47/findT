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
    
    
    let sections = ["findT", "options"]
    let tempTitle = ["임시1", "임시2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func switchChanged(sender: UISwitch!) {
        print("Switch value is \(sender.isOn)")
        print("Switch item is \(sender.tag)")
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

            cell.contentView.addSubview(titleImage)
            titleImage.snp.makeConstraints { make in
                make.height.width.equalTo(self.view.frame.height / 5)
                make.left.equalToSuperview().offset(10)
            }

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
                cell.stackView.rightSwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: .touchUpInside)
                return cell
            case 1:
                let cell = UITableViewCell()
                let stackView = LabelLabelStackView()
                cell.contentView.addSubview(stackView)
                stackView.leftLabel.text = "Version"
                stackView.leftLabel.font = .systemFont(ofSize: 17)
                stackView.rightLabel.text = INFO.findTVersion
                stackView.rightLabel.font = .boldSystemFont(ofSize: 18)
                stackView.rightLabel.textColor = UIColor(red: 0.40, green: 0.40, blue: 0.67, alpha: 1.00)
                stackView.snp.makeConstraints { make in
                    make.left.equalTo(30)
                    make.right.equalTo(-20)
                    make.height.equalTo(44)
                }

                cell.selectionStyle = .none
                return cell
            default:
                let cell = UITableViewCell()
                let cellSwitch = UISwitch()
                cell.accessoryView = cellSwitch
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
