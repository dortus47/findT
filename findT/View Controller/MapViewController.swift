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
import SSLog

final class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate {
    
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
        button.tintColor = .black
        button.frame.size.height = 80
        button.frame.size.width = 80
        return button
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.backgroundColor = UIColor(white: 1.0, alpha: 1)
        searchBar.searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.layer.borderWidth = 1.4
        searchBar.searchTextField.layer.cornerRadius = 9
        searchBar.placeholder = "조회를 원하는 역을 입력하세요"
        return searchBar
    }()
    
    lazy var locationManager: CLLocationManager = CLLocationManager() /// location manager
    var currentLocation: CLLocation! /// 내 위치 저장
    
    lazy var networkManager: NetWorkManager = NetWorkManager()
    
    let dobongLoc = CLLocationCoordinate2D(latitude: 37.6658609, longitude: 127.0317674) // 도봉구
    let eunpyeongLoc = CLLocationCoordinate2D(latitude: 37.6176125, longitude: 126.9227004) // 은평구
    let dongdaemoonLoc = CLLocationCoordinate2D(latitude: 37.5838012, longitude: 127.0507003) // 동대문구
    let gasanLoc = CLLocationCoordinate2D(latitude: 37.481072, longitude: 126.882343) // 가산디지털단지
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViewProcess()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.locationErrorProcess()
        self.getDPToilet()
        self.getRouteInformation()
    }
    
    private func initViewProcess() {
        let tabBarHeight = self.tabBarController!.tabBar.frame.size.height * -1
        
        searchBar.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        self.currentLocation = locationManager.location
        self.mapView.mapType = MKMapType.standard
        
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
    
    /// 검색된 위치로 이동 & marker 추가
    private func searchMapView(cordinate: CLLocationCoordinate2D, addr: String) {
        let region = MKCoordinateRegion(center: cordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        
        let anootation = MKPointAnnotation()
        anootation.coordinate = cordinate
        anootation.title = addr
        self.mapView.addAnnotation(anootation)
        self.findAddr(lat: cordinate.latitude, long: cordinate.longitude)
    }
    
    // MARK: - APIs
    
    private func getDPToilet() {
        let body = [
            "serviceKey": INFO.serviceKey,
            "format": "JSON",
            "railOprIsttCd": "S1",
            "lnCd": "3",
            "stinCd": "322"
        ]
        networkManager.downloadJSON(url: API.toiletURL, parameters: body)
            .subscribe { event in
                switch event {
                case let .next(jsonObj):
                    do {
                        let jsonData:Data = try JSONEncoder().encode(jsonObj)
                        let str = String.init(data: jsonData, encoding: .utf8)!.data(using: .utf8)!
                        let result: DPToilet = try JSONDecoder().decode(DPToilet.self, from: str)
                        print(result)
                    } catch {
                        print("error")
                    }
                case .completed:
                    break
                case .error:
                    break
                }
            }
    }
    
    private func getRouteInformation() {
//        let body = [
//            "serviceKey": INFO.serviceKey,
//            "format": "JSON",
//            "railOprIsttCd": "KR",
//            "lnCd": "1",
//            "stinCd": "135",
//            "stinNm": "용산"
//        ]
        let body = [
            "serviceKey": INFO.serviceKey,
            "format": "JSON",
            "railOprIsttCd": "KR",
            "lnCd": "1",
            "stinCd": "746",
            "stinNm": "가산디지털단지"
        ]
        networkManager.downloadJSON(url: API.informationByStationURL, parameters: body)
            .subscribe { event in
                switch event {
                case let .next(jsonObj):
                    print(jsonObj)
//                    do {
//                        let jsonData:Data = try JSONEncoder().encode(jsonObj)
//                        let str = String.init(data: jsonData, encoding: .utf8)!.data(using: .utf8)!
//                        let result: DPToilet = try JSONDecoder().decode(DPToilet.self, from: str)
//                        print(result)
//                    } catch {
//                        print("error")
//                    }
                case .completed:
                    break
                case .error:
                    break
                }
            }
    }
    
    
    // MARK: - Actions
    
    @objc private func didTapSelfPositionBtn() {
        print("click")
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //self.searchMapView(cordinate: dobongLoc, addr: searchBar.searchTextField.text!)
        self.searchMapView(cordinate: gasanLoc, addr: searchBar.searchTextField.text!)
    }
}
