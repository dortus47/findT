//
//  FileManager.swift
//  findT
//
//  Created by 장은석 on 2021/12/29.
//

import Foundation

final class FileManager {
    lazy var stationDictionary: [String: stationLocation] = [String: stationLocation]()
    
    func setStationCoordinate() {
        let jsonPath = Bundle.main.path(forResource: "station_coordinate", ofType: "json")!
        if let data = try? String(contentsOfFile: jsonPath).data(using: .utf8) {
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String : Any]]
            for jsonIndex in json {
//                print(jsonIndex)
                let key = jsonIndex["name"] as! String
                let value = stationLocation(jsonIndex["lng"] as? String, jsonIndex["lat"] as? String, jsonIndex["code"] as? String, jsonIndex["line"] as? String, jsonIndex["name"] as? String)
                stationDictionary[key] = value
            }
        }
    }
}
