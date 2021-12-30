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

class MapViewController: UIViewController, UISearchBarDelegate {
    
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
    
    lazy var fileManager: FileManager = FileManager()
    lazy var networkManager: NetWorkManager = NetWorkManager()
    lazy var colorManager: ColorManager = ColorManager()
    lazy var locationManager: CLLocationManager = CLLocationManager() /// location manager
    var currentLocation: CLLocation! /// 내 위치 저장

    
    let gasanLoc = CLLocationCoordinate2D(latitude: 37.481072, longitude: 126.882343) // 가산디지털단지
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViewProcess()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.locationErrorProcess()
        self.addMarker()
    }
    
    private func initViewProcess() {
        searchBar.delegate = self
        locationManager.delegate = self
        mapView.delegate = self
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
            let tabBarHeight = self.tabBarController!.tabBar.frame.size.height * -1
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
    
    // 위치 받아오기 에러 처리
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
    
    // 위도, 경도에 따른 주소 찾기
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
    
    // station_cordinate.json 파싱, 모든 역 핀업 추가
    private func addMarker() {
        fileManager.setStationCoordinate()
        for stationItem in fileManager.stationDictionary {
            guard let latitude = stationItem.value.lat else {
                continue
            }

            guard let longitude = stationItem.value.lng else {
                continue
            }
            
            let mark = Marker(
                title: stationItem.value.name! + "역",
                subtitle: stationItem.value.line!,
                coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                pinTintColor: colorManager.lineDictionary[stationItem.value.line!] ?? UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
            )
           mapView.addAnnotation(mark)
        }
    }
    
    // 검색된 위치로 이동
    private func searchMapView(cordinate: CLLocationCoordinate2D, addr: String) {
        let region = MKCoordinateRegion(center: cordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        self.findAddr(lat: cordinate.latitude, long: cordinate.longitude)
    }
    
    // MARK: - Actions

    @objc private func didTapSelfPositionBtn() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    // 검색버튼 이벤트, 검색창에 역을 붙이거나 붙이지 않아도 같은 결과를 얻도록 전처리
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var text = searchBar.searchTextField.text!
        if text.lastString == "역" {
            text = String(text.dropLast(1))
        }
        
        guard let stationName = fileManager.stationDictionary[text]?.name else {
            return
        }
        
        guard let latitude = fileManager.stationDictionary[text]?.lat else {
            return
        }

        guard let longitude = fileManager.stationDictionary[text]?.lng else {
            return
        }
        
        let loc = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.searchMapView(cordinate: loc, addr: stationName)
    }
}

extension MapViewController: CLLocationManagerDelegate {
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
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView()

        if let annotation = annotation as? Marker {
            annotationView.markerTintColor = annotation.pinTintColor
        }
        let button = UIButton(type:.detailDisclosure)
        button.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }
        annotationView.leftCalloutAccessoryView = button
        return annotationView
    }
    
    // 해당 마커 클릭 동작 로직
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let region = MKCoordinateRegion(center: view.annotation!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
//        let pushViewContoller = SetttingsTableViewController()
//        self.present(pushViewContoller, animated: true, completion: nil)

//        self.navigationController?.pushViewController(pushViewContoller, animated: true)
    }
}
