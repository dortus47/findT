//
//  StationListTableViewCell.swift
//  findT
//
//  Created by 장은석 on 2022/01/04.
//

import UIKit

class StationListTableViewCell: UITableViewCell {
    
    static let identifier = "StationListTableViewCell"
    
    lazy var stackView: LabelLabelStackView = LabelLabelStackView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.addSubview(stackView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(name: String, line: String, color: UIColor) {
        stackView.leftLabel.text = name
        stackView.leftLabel.font = .boldSystemFont(ofSize: 18)
        stackView.rightLabel.text = line
        stackView.rightLabel.font = .systemFont(ofSize: 17)
        stackView.rightLabel.textColor = color
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(44)
        }
    }
}
