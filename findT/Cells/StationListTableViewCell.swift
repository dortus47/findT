//
//  StationListTableViewCell.swift
//  findT
//
//  Created by 장은석 on 2022/01/04.
//

import UIKit

class StationListTableViewCell: UITableViewCell {
    
    static let identifier = "StationListTableViewCell"
    
    let testView: DetailInfoStackView = DetailInfoStackView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.addSubview(testView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(name: String) {
        testView.leftLabel.text = name
    }
}
