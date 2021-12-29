//
//  NetworkManager.swift
//  findT
//
//  Created by 장은석 on 2021/12/25.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

final class NetWorkManager {
    
    func downloadJSON(url: String, parameters: Dictionary<String, Any>) -> Observable<JSON?>  {
        return Observable.create { observer in
            DispatchQueue.global().async {
                
                AF.request(url,
                           method: .get,
                           parameters: parameters,
                           encoding: URLEncoding.default,
                           headers: API.header)
                    .validate(statusCode: 200..<300)
                    .responseJSON { response in
                        switch response.result {
                        case .success(let res):
                            let jsonObj = JSON(res)["body"][0]
                            observer.onNext(jsonObj)
                        case .failure(let err):
                            print(err.localizedDescription)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    // MARK: - APIs
    
    func getDPToilet() {
        let body = [
            "serviceKey": INFO.serviceKey,
            "format": "JSON",
            "railOprIsttCd": "S1",
            "lnCd": "3",
            "stinCd": "322"
        ]
        downloadJSON(url: API.toiletURL, parameters: body)
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
    
    func getRouteInformation() {
        let body = [
            "serviceKey": INFO.serviceKey,
            "format": "JSON",
            "railOprIsttCd": "KR",
            "lnCd": "1",
            "stinCd": "746",
            "stinNm": "가산디지털단지"
        ]
        downloadJSON(url: API.informationByStationURL, parameters: body)
            .subscribe { event in
                switch event {
                case let .next(jsonObj):
                    print(jsonObj)
                case .completed:
                    break
                case .error:
                    break
                }
            }
    }
    
    //    func requestDPToilet() -> DPToilet {
    //        var toilet: DPToilet = DPToilet()
    //
    //        AF.request(API.toiletURL,
    //                   method: .get,
    //                   parameters: [
    //                    "serviceKey": INFO.serviceKey,
    //                    "format": "JSON",
    //                    "railOprIsttCd": "S1",
    //                    "lnCd": "3",
    //                    "stinCd": "322"
    //                   ],
    //                   encoding: URLEncoding.default,
    //                   headers: API.header)
    //            .validate(statusCode: 200..<300)
    //            .responseJSON { response in
    //                switch response.result {
    //                case .success(let res):
    //                    let jsonObj = JSON(res)["body"][0]
    //                    do {
    //                        let jsonData:Data = try JSONEncoder().encode(jsonObj)
    //                        let str = String.init(data: jsonData, encoding: .utf8)!.data(using: .utf8)!
    //                        let result: DPToilet = try JSONDecoder().decode(DPToilet.self, from: str)
    //                        toilet = result
    //                    } catch {
    //                        print("error")
    //                    }
    //                case .failure(let err):
    //                    print(err.localizedDescription)
    //                }
    //            }
    //        print(toilet)
    //        return toilet
    //    }
}
