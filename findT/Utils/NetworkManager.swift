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
    
    let disposeBag = DisposeBag()
    
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
    
    func getDPToilet(railOprIsttCd: String?, lnCd: String?, stinCd: String?) -> DPToilet? {
        guard let railOprIsttCd = railOprIsttCd,
                let lnCd = lnCd,
                let stinCd = stinCd else {
                    return nil
        }

        var toilet: DPToilet = DPToilet()

        let body = [
            "serviceKey": INFO.serviceKey,
            "format": "JSON",
            "railOprIsttCd": railOprIsttCd,
            "lnCd": lnCd,
            "stinCd": stinCd
        ]
        downloadJSON(url: API.stationDisabledToiletURL, parameters: body)
            .subscribe { event in
                switch event {
                case let .next(jsonObj):
                    do {
                        let jsonData:Data = try JSONEncoder().encode(jsonObj)
                        let str = String.init(data: jsonData, encoding: .utf8)!.data(using: .utf8)!
                        let result: DPToilet = try JSONDecoder().decode(DPToilet.self, from: str)
                        toilet = result
                    } catch {
                        print("error")
                    }
                case .completed:
                    break
                case .error:
                    break
                }
            }.disposed(by: disposeBag)
        return toilet
    }
}
