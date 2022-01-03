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
    
    let dtlLocView: DetailInfoStackView = DetailInfoStackView()         // 상세위치
    let mlFmlDvNmView: DetailInfoStackView = DetailInfoStackView()      // 남녀구분
    let grndDvNmView: DetailInfoStackView = DetailInfoStackView()       // 지상구분
    let gateInotDvNmView: DetailInfoStackView = DetailInfoStackView()   // 게이트내외구분
    let stinFlorNumView: DetailInfoStackView = DetailInfoStackView()    // 역층
    let exitNoView: DetailInfoStackView = DetailInfoStackView()         // 출구번호

    

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViewProcess()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

// MARK: - SnapKit

extension StationInfoViewController {
    
    func initViewProcess() {
        self.view.backgroundColor = .white
        
        view.setNeedsUpdateConstraints()

        dtlLocView.leftLabel.text = "상세위치"
        dtlLocView.rightLabel.text = toiletInfo.dtlLoc ?? "-"
        
        mlFmlDvNmView.leftLabel.text = "남녀구분"
        mlFmlDvNmView.rightLabel.text = toiletInfo.mlFmlDvNm ?? "-"
        
        grndDvNmView.leftLabel.text = "지상구분"
        grndDvNmView.rightLabel.text = toiletInfo.grndDvNm ?? "-"
        
        gateInotDvNmView.leftLabel.text = "게이트내외구분"
        gateInotDvNmView.rightLabel.text = toiletInfo.gateInotDvNm ?? "-"
        
        stinFlorNumView.leftLabel.text = "역층"
        stinFlorNumView.rightLabel.text = toiletInfo.stinFlor ?? "-"
        
        exitNoView.leftLabel.text = "출구번호"
        exitNoView.rightLabel.text = toiletInfo.exitNo ?? "-"
        
        self.view.addSubview(dtlLocView)
        self.view.addSubview(mlFmlDvNmView)
        self.view.addSubview(grndDvNmView)
        self.view.addSubview(gateInotDvNmView)
        self.view.addSubview(stinFlorNumView)
        self.view.addSubview(exitNoView)
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            
            // 상세위치
            dtlLocView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
            }
            
            // 남녀구분
            mlFmlDvNmView.snp.makeConstraints { make in
                make.top.equalTo(dtlLocView.snp.bottom).offset(20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
            }
            
            // 지상구분
            grndDvNmView.snp.makeConstraints { make in
                make.top.equalTo(mlFmlDvNmView.snp.bottom).offset(20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
            }
            
            // 게이트내외구분
            gateInotDvNmView.snp.makeConstraints { make in
                make.top.equalTo(grndDvNmView.snp.bottom).offset(20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
            }
            
            // 출구번호
            stinFlorNumView.snp.makeConstraints { make in
                make.top.equalTo(gateInotDvNmView.snp.bottom).offset(20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
            }
            
            // 역층
            exitNoView.snp.makeConstraints { make in
                make.top.equalTo(stinFlorNumView.snp.bottom).offset(20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
            }
            
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}
