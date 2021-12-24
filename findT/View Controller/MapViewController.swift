//
//  MapViewController.swift
//  findT
//
//  Created by 장은석 on 2021/12/23.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation
import Alamofire

final class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
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
    
    var locationManager: CLLocationManager = CLLocationManager() /// location manager
    var currentLocation: CLLocation! /// 내 위치 저장
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViewProcess()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.locationErrorProcess()
    }
    
    private func initViewProcess() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        self.currentLocation = locationManager.location
        
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
            make.top.bottom.equalTo(self.view)
        }
        
        self.mapView.mapType = MKMapType.standard
        
        self.view.addSubview(selfPositionBtn)
        selfPositionBtn.snp.makeConstraints { make in
            //make.width.height.equalTo(50)
            make.bottom.equalTo(self.view).offset(-100)
            make.right.equalTo(self.view).offset(-30)
        }
        selfPositionBtn.addTarget(self, action: #selector(didTapSelfPositionBtn), for: .touchUpInside)
    }
    
    // MARK: - Map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined :
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse :
            self.currentLocation = locationManager.location
        case .authorizedAlways :
            self.currentLocation = locationManager.location
        case .restricted :
            break
        case .denied :
            break
        default :
            break
        }
    }
    
    /// 위치 받아오기 에러 처리
    private func locationErrorProcess() {
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
                let alert = UIAlertController(title: "오류 발생", message: "위치 서비스 기능이 꺼져있음", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
                self.mapView.showsUserLocation = true
                self.mapView.setUserTrackingMode(.follow, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "오류 발생", message: "위치 서비스 기능이 꺼져있음", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapSelfPositionBtn() {
        print("click")
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    
    
    func getTest() {
        //            let url = "https://jsonplaceholder.typicode.com/todos/1"
        //            AF.request(url,
        //                       method: .get,
        //                       parameters: nil,
        //                       encoding: URLEncoding.default,
        //                       headers: ["Content-Type": "application/json", "Accept": "application/json"])
        //                .validate(statusCode: 200..<300)
        //                .responseJSON { (json) in
        //                    // 여기서 가져온 데이터를 자유롭게 활용하세요.
        //                    print(json)
        //            }
    }
    
}
