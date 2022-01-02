//
//  StationInfoViewController.swift
//  findT
//
//  Created by 장은석 on 2021/12/30.
//

import UIKit
import SnapKit

class StationInfoViewController: UIViewController {
    var didSetupConstraints = false
    
    var toiletInfo = DPToilet()
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .label
        label.numberOfLines = 1
        label.backgroundColor = .green
        label.text = "제목"
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .label
        label.numberOfLines = 1
        label.backgroundColor = .blue
        label.text = "내용"
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .red
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        return stack
    }()

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - SnapKit

extension StationInfoViewController {
    
    func initUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(leftLabel)
        self.stackView.addArrangedSubview(rightLabel)
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            stackView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(50)
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}
