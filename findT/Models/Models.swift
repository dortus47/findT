//
//  Models.swift
//  findT
//
//  Created by 장은석 on 2021/12/26.
//

import Foundation

/// disabled person, 장애인 화장실의 정보
struct DPToilet: Codable {
    let diapExchNum: String? //      기저귀교환대개수
    let dtlLoc: String? //           상세위치
    let exitNo: String? //           출구번호
    let gateInotDvNm: String? //     게이트내외구분
    let grndDvNm: String? //         지상구분
    let lnCd: String? //             선코드
    let mlFmlDvNm: String? //        남녀구분
    let railOprIsttCd: String? //    철도운영기관코드
    let stinCd: String? //           역코드
    let stinFlor: String? //         역층
    let toltNum: String? //          화장실개수
    
    enum CodingKeys: String, CodingKey {
        case diapExchNum, dtlLoc, exitNo, gateInotDvNm, grndDvNm, lnCd, mlFmlDvNm, railOprIsttCd, stinCd, stinFlor, toltNum
    }
    
    init() {
        self.diapExchNum = nil
        self.dtlLoc = nil
        self.exitNo = nil
        self.gateInotDvNm = nil
        self.grndDvNm = nil
        self.lnCd = nil
        self.mlFmlDvNm = nil
        self.railOprIsttCd = nil
        self.stinCd = nil
        self.stinFlor = nil
        self.toltNum = nil
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        diapExchNum = (try? values.decode(String?.self, forKey: .diapExchNum)) ?? nil
        dtlLoc = (try? values.decode(String?.self, forKey: .dtlLoc)) ?? nil
        exitNo = (try? values.decode(String?.self, forKey: .exitNo)) ?? nil
        gateInotDvNm = (try? values.decode(String?.self, forKey: .gateInotDvNm)) ?? nil
        grndDvNm = (try? values.decode(String?.self, forKey: .grndDvNm)) ?? nil
        lnCd = (try? values.decode(String?.self, forKey: .lnCd)) ?? nil
        mlFmlDvNm = (try? values.decode(String?.self, forKey: .mlFmlDvNm)) ?? nil
        railOprIsttCd = (try? values.decode(String?.self, forKey: .railOprIsttCd)) ?? nil
        stinCd = (try? values.decode(String?.self, forKey: .stinCd)) ?? nil
        stinFlor = (try? values.decode(String?.self, forKey: .stinFlor)) ?? nil
        toltNum = (try? values.decode(String?.self, forKey: .toltNum)) ?? nil
    }
}
