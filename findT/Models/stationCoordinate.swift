//
//  stationCoordinate.swift
//  findT
//
//  Created by 장은석 on 2021/12/29.
//

import Foundation

struct stationLocation {
    let lng: String?        // 127.042292
    let lat: String?        // 37.75938
    let code: String?       // 1908
    let line: String?       // 01호선
    let name: String?       // 녹양
    
    init() {
        self.lng = nil
        self.lat = nil
        self.code = nil
        self.line = nil
        self.name = nil
    }
    
    init(_ lng: String?, _ lat: String?, _ code: String?, _ line: String?, _ name: String?) {
        self.lng = lng
        self.lat = lat
        self.code = code
        self.line = line
        self.name = name
    }
}
