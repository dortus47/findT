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

class NetWorkManager {
    
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
