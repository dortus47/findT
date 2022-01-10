//
//  StationListTableViewCell.swift
//  findT
//
//  Created by 장은석 on 2022/01/04.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"
    
    var stackView: LabelSwitchUIStackView = LabelSwitchUIStackView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-20)
            make.height.equalTo(44)
        }
        stackView.rightSwitch.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(name: String) {
        stackView.leftLabel.text = name
        stackView.leftLabel.font = .boldSystemFont(ofSize: 18)
    }
}
