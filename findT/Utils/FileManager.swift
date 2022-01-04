//
//  FileManager.swift
//  findT
//
//  Created by 장은석 on 2021/12/29.
//
import Foundation

final class FileManager {
    static var stationCordinateDictionary = [String: stationLocation]()
    static var stationCodeInfoDictionary = [String: stationCodeInfo]()
    
    // station_coordinate.json 파일을 파싱, map의 marker를 찍어줄 때 사용됨
    static func setStationCoordinate() {
        let jsonPath = Bundle.main.path(forResource: "station_coordinate", ofType: "json")!
        if let data = try? String(contentsOfFile: jsonPath).data(using: .utf8) {
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String : Any]]
            for jsonIndex in json {
                let key = jsonIndex["name"] as! String
                let value = stationLocation(
                    jsonIndex["lng"] as? Double,
                    jsonIndex["lat"] as? Double,
                    jsonIndex["code"] as? Int,
                    jsonIndex["line"] as? String,
                    jsonIndex["name"] as? String
                )
                FileManager.stationCordinateDictionary[key] = value
            }
        }
    }
    
    // station_code_info.json 파일을 파싱, 해당 역의 장애인 화장실 정보 API의 입력값으로 사용되는 정보들.
    static func setStationInfo() {
        let jsonPath = Bundle.main.path(forResource: "station_code_info", ofType: "json")!
        if let data = try? String(contentsOfFile: jsonPath).data(using: .utf8) {
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String : Any]]
            for jsonIndex in json {
                let key = (jsonIndex["LN_NM"] as! String) + (jsonIndex["STIN_NM"] as! String)
                let value = stationCodeInfo(
                    jsonIndex["LN_CD"] as? String,
                    jsonIndex["LN_NM"] as? String,
                    jsonIndex["RAIL_OPR_ISTT_CD"] as? String,
                    jsonIndex["RAIL_OPR_ISTT_NM"] as? String,
                    jsonIndex["STIN_CD"] as? String,
                    jsonIndex["STIN_NM"] as? String
                )
                FileManager.stationCodeInfoDictionary[key] = value
            }
        }
    }
    
    static func loadFileDataProcess() {
        FileManager.setStationCoordinate()
        FileManager.setStationInfo()
    }
}
