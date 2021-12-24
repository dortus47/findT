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

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.backgroundColor = UIColor(red: 256, green: 256, blue: 256, alpha: 1)
        searchBar.searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.layer.borderWidth = 1.4
        searchBar.searchTextField.layer.cornerRadius = 9
        searchBar.placeholder = "조회를 원하는 역을 입력하세요"
        return searchBar
    }()

    var locationManager: CLLocationManager = CLLocationManager() /// location manager
    var currentLocation: CLLocation! /// 내 위치 저장

    let dobongLoc = CLLocationCoordinate2D(latitude: 37.6658609, longitude: 127.0317674) // 도봉구
    let eunpyeongLoc = CLLocationCoordinate2D(latitude: 37.6176125, longitude: 126.9227004) // 은평구
    let dongdaemoonLoc = CLLocationCoordinate2D(latitude: 37.5838012, longitude: 127.0507003) // 동대문구

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
        self.mapView.mapType = MKMapType.standard

        let tabBarHeight = self.tabBarController!.tabBar.frame.size.height * -1
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.bottom.equalToSuperview().offset(tabBarHeight)
        }

        self.view.addSubview(selfPositionBtn)
        selfPositionBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.right.equalToSuperview().offset(-30)
        }

        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }

//        searchBar.superview?.backgroundColor = .clear
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

    /// 위도, 경도에 따른 주소 찾기
    private func findAddr(lat: CLLocationDegrees, long: CLLocationDegrees) {
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")

        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { (placemarks, _) in
            if let address: [CLPlacemark] = placemarks {
                var myAdd: String =  ""
                if let area: String = address.last?.locality {
                    myAdd += area
                }
                if let name: String = address.last?.name {
                    myAdd += " "
                    myAdd += name
                }
            }
        }
    }

    // MARK: - Actions

    @objc private func didTapSelfPositionBtn() {
        print("click")
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
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
