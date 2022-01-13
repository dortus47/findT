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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 24)
        label.textColor = UIColor(red: 0.40, green: 0.40, blue: 0.67, alpha: 1.00)
        label.numberOfLines = 1
        label.text = "findT"
        return label
    }()
    
    
    let sections = ["findT", "options"]
    let tempTitle = ["title1", "title2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func switchChanged(sender: UISwitch!) {
        let value = (sender as AnyObject).isOn // true면 저장, false면 저장안함
        let plist = UserDefaults.standard // 기본 저장소 객체를 가져온다.
        plist.set(value, forKey: "sound")
        plist.synchronize() // 동기화 처리
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
            cell.selectionStyle = .none
            let titleImage = UIImageView(image: UIImage(named: "circle.png"))

            cell.contentView.addSubview(titleImage)
            cell.contentView.addSubview(titleLabel)
            titleImage.snp.makeConstraints { make in
                make.width.height.equalTo(self.view.frame.height / 7)
                make.left.equalToSuperview().offset(10)
                make.top.equalToSuperview().offset(15)
                make.bottom.equalToSuperview().offset(-15)
            }
            
            cell.contentView.snp.makeConstraints { make in
                make.height.equalTo((self.view.frame.height / 7) + 30)
                make.width.equalToSuperview()
            }

            titleLabel.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-25)
                make.top.equalToSuperview().offset(25)
            }
            
            return cell
        }

        // options
        else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let cell = SettingTableViewCell()
                cell.setData(name: "Sounds")
                let plist = UserDefaults.standard // 기본 저장소 객체를 가져온다.
                cell.stackView.rightSwitch.isOn = plist.bool(forKey: "sound")
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
