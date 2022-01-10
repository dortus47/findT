//
//  LabelSwitchUIStackView.swift
//  findT
//
//  Created by 장은석 on 2022/01/09.
//

import UIKit

class LabelSwitchUIStackView: UIStackView {
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "제목"
        return label
    }()
    
    let rightSwitch: UISwitch = {
        let rightSwitch = UISwitch()
        rightSwitch.onTintColor = UIColor(red: 0.40, green: 0.40, blue: 0.67, alpha: 1.00)
        return rightSwitch
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.axis = .horizontal
        self.spacing = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.addArrangedSubview(leftLabel)
        self.addArrangedSubview(rightSwitch)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
