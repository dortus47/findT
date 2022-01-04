//
//  MapViewController.swift
//  findT
//
//  Created by 장은석 on 2021/12/23.
//

import UIKit
import MapKit
import SnapKit
import RxSwift
import CoreLocation

class MapViewController: UIViewController, UISearchBarDelegate {
    
    lazy var disposeBag = DisposeBag()
    
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
    
    lazy var fileManager = FileManager.shared
    lazy var networkManager: NetWorkManager = NetWorkManager()
    lazy var colorManager: ColorManager = ColorManager()
    lazy var locationManager: CLLocationManager = CLLocationManager() /// location manager
    var currentLocation: CLLocation! /// 내 위치 저장
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("1 before")
        self.initViewProcess()
        fileManager.loadFileDataProcess()
        print("1 after")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.locationErrorProcess()
        self.addMarker()
    }
    
    // MARK: - SnapKit
    
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
    
    // station_cordinate.json 파싱, 모든 역 핀업 추가
    private func addMarker() {
        for stationItem in fileManager.stationCordinateDictionary {
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
    }
    
    // MARK: - Actions
    
    @objc private func didTapSelfPositionBtn() {
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
        
        guard let stationName = fileManager.stationCordinateDictionary[text]?.name else {
            return
        }
        
        guard let latitude = fileManager.stationCordinateDictionary[text]?.lat else {
            return
        }
        
        guard let longitude = fileManager.stationCordinateDictionary[text]?.lng else {
            return
        }
        
        let loc = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.searchMapView(cordinate: loc, addr: stationName)
    }
    
    // 맵에서 핀 클릭 시, 데이터가 없을 때 팝업되는 경고창
    private func setAlertAcion() {
        let alert = UIAlertController(title:"조회된 데이터가 없습니다.",
                                      message: nil,
                                      preferredStyle: UIAlertController.Style.alert
        )
        let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancle)
        self.present(alert,animated: true,completion: nil)
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
        let upPosition = CLLocationCoordinate2D(latitude: view.annotation!.coordinate.latitude - MAPINFO.upLatitude, longitude: view.annotation!.coordinate.longitude)
        let region = MKCoordinateRegion(center: upPosition, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        
        // 클릭한 마커가 자기 자신의 위치일 경우, 아래 로직은 실행하지 않고 종료.
        if view.annotation?.title == "My Location" {
            return
        }
        
        LoadingService.showLoading()
        
        var text: String = view.annotation!.title! ?? ""
        if text.lastString == "역" {
            text = String(text.dropLast(1))
        }
        
        // 역 코드 정보 dic은 subtitle과 tilte의 합(LN_NM + STIN_NM)
        let key = (view.annotation!.subtitle! ?? "") + (text)
        let info = fileManager.stationCodeInfoDictionary[key]
        
        let lnCd: String? = info?.LN_CD // 선코드
        let railOprIsttCd: String? = info?.RAIL_OPR_ISTT_CD // 철도운영기관코드
        let stinCd: String? = info?.STIN_CD // 역코드
        
        guard let railOprIsttCd = railOprIsttCd,
              let lnCd = lnCd,
              let stinCd = stinCd else {
                  LoadingService.hideLoading()
                  self.setAlertAcion()
                  return
              }
        
        let body = [
            "serviceKey": INFO.serviceKey,
            "format": "JSON",
            "railOprIsttCd": railOprIsttCd,
            "lnCd": lnCd,
            "stinCd": stinCd
        ]
        
        networkManager.downloadJSON(url: API.stationDisabledToiletURL, parameters: body)
            .subscribe { event in
            switch event {
            case let .next(jsonObj):
                do {
                    let jsonData: Data = try JSONEncoder().encode(jsonObj)
                    let str = String.init(data: jsonData, encoding: .utf8)!.data(using: .utf8)!
                    let result: DPToilet? = try JSONDecoder().decode(DPToilet.self, from: str)
                    
                    guard let result = result else {
                        LoadingService.hideLoading()
                        self.setAlertAcion()
                        return
                    }
                    
                    let vc = StationInfoViewController()
                    vc.toiletInfo = result
                    LoadingService.hideLoading()
                    if #available(iOS 15.0, *) {
                        if let presentationController = vc.presentationController as? UISheetPresentationController {
                            presentationController.detents = [.medium()]
                            self.present(vc, animated: true)
                        }
                    } else {
                        // Fallback on earlier versions
                        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                        self.present(vc, animated: true, completion: nil)
                    }

                } catch {
                    print("error")
                }
            case .completed:
                break
            case .error:
                break
            }
        }.disposed(by: disposeBag)
    }
}
