//
//  Constants.swift
//  findT
//
//  Created by 장은석 on 2021/12/24.
//

import Foundation
import Alamofire

enum INFO {
    static let serviceID: String = "vulnerableUserInfo"

    static let operationID : String = "stationDisabledToilet"

    static let serviceKey: String = "$2a$10$5wDUZNY4j/mcxX3Uca26muPtCiCiyFgx0xBBvTGIbkjtr7Ik6p5jy"
    
    static let periodOfUse: String = "2021.12.23 ~ 2022.12.23"
    
    static let findTVersion: String = "1.0.4"
}

enum API {
    static let stationDisabledToiletURL: String = "http://openapi.kric.go.kr/openapi/vulnerableUserInfo/stationDisabledToilet"
    
    static let header: HTTPHeaders = ["Content-Type":"application/json; charset=utf-8", "Accept":"application/json; charset=utf-8"]
}

enum MAPINFO {
    static let upLatitude: Double = 0.0013
}
