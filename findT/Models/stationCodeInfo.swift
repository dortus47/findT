//
//  stationCodeInfo.swift
//  findT
//
//  Created by 장은석 on 2021/12/31.
//

import Foundation

struct stationCodeInfo {
    let LN_CD: String?                  // 1
    let LN_NM: String?                  // 01호선
    let RAIL_OPR_ISTT_CD: String?       // S1
    let RAIL_OPR_ISTT_NM: String?       // 서울교통공사(구서울메트로)
    let STIN_CD: String?                // 128
    let STIN_NM: String?                // 동대문
    
    init() {
        self.LN_CD = nil
        self.LN_NM = nil
        self.RAIL_OPR_ISTT_CD = nil
        self.RAIL_OPR_ISTT_NM = nil
        self.STIN_CD = nil
        self.STIN_NM = nil
    }
    
    init(_ LN_CD: String?, _ LN_NM: String?, _ RAIL_OPR_ISTT_CD: String?, _ RAIL_OPR_ISTT_NM: String?, _ STIN_CD: String?, _ STIN_NM: String?) {
        self.LN_CD = LN_CD
        self.LN_NM = LN_NM
        self.RAIL_OPR_ISTT_CD = RAIL_OPR_ISTT_CD
        self.RAIL_OPR_ISTT_NM = RAIL_OPR_ISTT_NM
        self.STIN_CD = STIN_CD
        self.STIN_NM = STIN_NM
    }
}
