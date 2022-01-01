//
//  SettingTableViewCell.swift
//  findT
//
//  Created by 장은석 on 2021/12/31.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"
    
    let settingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .label
        label.numberOfLines = 1
        label.backgroundColor = .green
        return label
    }()
    
    let pinButton: UIButton = {
         let button = UIButton()
         button.tintColor = UIColor(red: 0.40, green: 0.40, blue: 0.67, alpha: 1.00)
         return button
     }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingLabel, pinButton])
        stackView.axis = .vertical
        stackView.spacing = 0
        
        return stackView
    }()
    
    // MARK: - Life Cycles
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        
        clipsToBounds = true
        contentView.addSubview(stackView)
                
        stackView.snp.makeConstraints { make in
            make.left.equalTo(settingLabel.snp.right).offset(20)
            make.centerY.equalTo(pinButton)
        }
        
        settingLabel.setLineHeight(lineHeight: contentView.frame.height)

        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
