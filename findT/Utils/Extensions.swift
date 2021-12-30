//
//  Extensions.swift
//  findT
//
//  Created by 장은석 on 2021/12/28.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// 바깥 영역 터치 시, 키보드 내리기
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

extension String
{
    /// EZSE: Converts String to Double
    public func toDouble() -> Double?
    {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// 열차 호선 색상
    public func getLineUIColor() -> UIColor {
        switch self {
        case "01호선":
            return UIColor(red: 0.05, green: 0.20, blue: 0.50, alpha: 1.00)
        case "02호선":
            return UIColor(red: 0.00, green: 0.62, blue: 0.24, alpha: 1.00)
        case "03호선":
            return UIColor(red: 0.94, green: 0.49, blue: 0.11, alpha: 1.00)
        case "04호선":
            return UIColor(red: 0.00, green: 0.65, blue: 0.87, alpha: 1.00)
        case "05호선":
            return UIColor(red: 0.60, green: 0.42, blue: 0.67, alpha: 1.00)
        case "06호선":
            return UIColor(red: 0.80, green: 0.49, blue: 0.18, alpha: 1.00)
        case "07호선":
            return UIColor(red: 0.45, green: 0.50, blue: 0.00, alpha: 1.00)
        case "08호선":
            return UIColor(red: 0.92, green: 0.33, blue: 0.36, alpha: 1.00)
        case "09호선":
            return UIColor(red: 0.73, green: 0.51, blue: 0.21, alpha: 1.00)
        case "분당선":
            return UIColor(red: 0.96, green: 0.64, blue: 0.00, alpha: 1.00)
        case "인천선":
            return UIColor(red: 0.49, green: 0.66, blue: 0.84, alpha: 1.00)
        case "인천2호선":
            return UIColor(red: 0.93, green: 0.55, blue: 0.00, alpha: 1.00)
        case "신분당선":
            return UIColor(red: 0.83, green: 0.00, blue: 0.23, alpha: 1.00)
        case "경의중앙선":
            return UIColor(red: 0.47, green: 0.77, blue: 0.64, alpha: 1.00)
        case "경춘선":
            return UIColor(red: 0.05, green: 0.56, blue: 0.45, alpha: 1.00)
        case "공항선":
            return UIColor(red: 0.00, green: 0.56, blue: 0.82, alpha: 1.00)
        case "의정부선":
            return UIColor(red: 0.99, green: 0.65, blue: 0.00, alpha: 1.00)
        case "의정부경전철":
            return UIColor(red: 0.99, green: 0.65, blue: 0.00, alpha: 1.00)
        case "수인선":
            return UIColor(red: 0.96, green: 0.64, blue: 0.00, alpha: 1.00)
        case "에버라인":
            return UIColor(red: 0.44, green: 0.70, blue: 0.42, alpha: 1.00)
        case "자기부상":
            return UIColor(red: 0.91, green: 0.58, blue: 0.35, alpha: 1.00)
        case "서해선":
            return UIColor(red: 0.51, green: 0.66, blue: 0.08, alpha: 1.00)
        case "경의선":
            return UIColor(red: 0.47, green: 0.77, blue: 0.64, alpha: 1.00)
        case "공항철도":
            return UIColor(red: 0.00, green: 0.40, blue: 0.70, alpha: 1.00)
        case "우이신설경전철":
            return UIColor(red: 0.72, green: 0.77, blue: 0.32, alpha: 1.00)
        case "경강선":
            return UIColor(red: 0.00, green: 0.24, blue: 0.65, alpha: 1.00)
        case "용인경전철":
            return UIColor(red: 0.31, green: 0.62, blue: 0.13, alpha: 1.00)
        case "김포도시철도":
            return UIColor(red: 0.63, green: 0.47, blue: 0.00, alpha: 1.00)
        default: 
            return UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
        }
    }
    
    var lastString: String {
        get {
            if self.isEmpty { return self }
            
            let lastIndex = self.index(before: self.endIndex)
            return String(self[lastIndex])
        }
    }
}
