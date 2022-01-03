//
//  DetailInfoStackView.swift
//  findT
//
//  Created by 장은석 on 2022/01/02.
//

import UIKit
import SnapKit

class DetailInfoStackView: UIStackView {
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "제목"
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .label
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0.40, green: 0.40, blue: 0.67, alpha: 1.00)
        label.text = "내용"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.axis = .horizontal
        self.spacing = 10
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.backgroundColor = .red
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.addArrangedSubview(leftLabel)
        self.addArrangedSubview(rightLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
