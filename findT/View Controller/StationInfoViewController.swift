//
//  StationInfoViewController.swift
//  findT
//
//  Created by 장은석 on 2021/12/30.
//

import UIKit
import SnapKit

class StationInfoViewController: UIViewController {
    
    let netWorkManager: NetWorkManager = NetWorkManager()

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        netWorkManager.getStationInfo(lineCode: "I2")
    }
}
