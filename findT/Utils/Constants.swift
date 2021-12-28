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
}

enum API {
    static let toiletURL: String = "http://openapi.kric.go.kr/openapi/vulnerableUserInfo/stationDisabledToilet"
    
    static let entireRouteURL: String = "http://openapi.kric.go.kr/openapi/trainUseInfo/subwayRouteInfo"
    
    static let informationByStationURL: String = "http://openapi.kric.go.kr/openapi/convenientInfo/stationInfo"
    
    static let header: HTTPHeaders = ["Content-Type":"application/json; charset=utf-8", "Accept":"application/json; charset=utf-8"]
}
