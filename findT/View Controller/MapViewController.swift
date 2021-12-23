//
//  MapViewController.swift
//  findT
//
//  Created by 장은석 on 2021/12/23.
//

import UIKit
import MapKit
import SnapKit
import Alamofire
import RxCocoa

final class MapViewController: UIViewController {
    
    lazy var mapView: MKMapView = {
       var mapView = MKMapView()
        return mapView
    }()
    
    let selfPositionBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .thin)
        let image = UIImage(systemName: "location", withConfiguration: config)
        button.setImage(image, for: .normal)
//        button.setBackgroundImage(UIImage(systemName: "location"), for: .normal)
        button.tintColor = .black
        button.frame.size.height = 80
        button.frame.size.width = 80
//        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
            make.top.bottom.equalTo(self.view)
        }
        
        self.view.addSubview(selfPositionBtn)
        selfPositionBtn.snp.makeConstraints { make in
            //make.width.height.equalTo(50)
            make.bottom.equalTo(self.view).offset(-100)
            make.right.equalTo(self.view).offset(-30)
        }

        
        //getTest()
    }
    
    func getTest() {
            let url = "https://jsonplaceholder.typicode.com/todos/1"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type": "application/json", "Accept": "application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { (json) in
                    // 여기서 가져온 데이터를 자유롭게 활용하세요.
                    print(json)
            }
        }

}
