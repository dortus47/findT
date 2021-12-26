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
    
    func requestSignUp() {
        let url = API.baseURL
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
            .responseDecodable(of: SimpleResponse<String>.self) { response in
                print("321\n\n")
                debugPrint(JSON(response.data))
                switch response.result {
                case .success(let res):
                    let json = JSON(res)
                    print("JSON: \(json)")
                case .failure(let err):
                    print("error\n\n")
                    print(err.localizedDescription)
                default:
                    print("default\n\n")
                    break
                }
            }
    }
}

struct SimpleResponse<T: Codable>: Codable {
    let header: T?
    let body: T?
    enum CodingKeys: CodingKey {
        case header, body
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        header = (try? values.decode(T.self, forKey: .header)) ?? nil
        body = (try? values.decode(T.self, forKey: .body)) ?? nil
    }
}
