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
    
    var lastString: String {
        get {
            if self.isEmpty { return self }
            
            let lastIndex = self.index(before: self.endIndex)
            return String(self[lastIndex])
        }
    }
}
