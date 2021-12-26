//
//  NetworkManager.swift
//  findT
//
//  Created by 장은석 on 2021/12/25.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetWorkManager {
    
    func requestDPToilet() -> DPToilet {
        let url = API.baseURL
        var toilet: DPToilet = DPToilet()
        
        AF.request(url,
                   method: .get,
                   parameters: [
                    "serviceKey": INFO.serviceKey,
                    "format": "JSON",
                    "railOprIsttCd": "S1",
                    "lnCd": "3",
                    "stinCd": "322"
                   ],
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json; charset=utf-8", "Accept":"application/json; charset=utf-8"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let res):
                    let jsonObj = JSON(res)["body"][0]
                    do {
                        let jsonData:Data = try JSONEncoder().encode(jsonObj)
                        let str = String.init(data: jsonData, encoding: .utf8)!.data(using: .utf8)!
                        let result: DPToilet = try JSONDecoder().decode(DPToilet.self, from: str)
                        toilet = result
                    } catch {
                        print("error")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        print(toilet)
        return toilet
    }
}
