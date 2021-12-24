//
//  Constants.swift
//  findT
//
//  Created by 장은석 on 2021/12/24.
//

import Foundation

enum INFO {
    static let serviceID: String = "vulnerableUserInfo"

    static let operationID : String = "stationDisabledToilet"

    static let serviceKey: String = "$2a$10$5wDUZNY4j/mcxX3Uca26muPtCiCiyFgx0xBBvTGIbkjtr7Ik6p5jy"

    static let periodOfUse: String = "2021.12.23 ~ 2022.12.23"
}

enum API {
    static let baseURL: String = "http://openapi.kric.go.kr/openapi/vulnerableUserInfo/stationDisabledToilet"
}
