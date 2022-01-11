//
//  Loading.swift
//  findT
//
//  Created by 장은석 on 2022/01/03.
//

import Foundation
import UIKit
import AudioToolbox

class LoadingService {
    static func showLoading() {
        DispatchQueue.main.async {
            // 아래 윈도우는 최상단 윈도우
            guard let window = UIApplication.shared.windows.last else { return }

            let loadingIndicatorView: UIActivityIndicatorView
            // 최상단에 이미 IndicatorView가 있는 경우 그대로 사용.
            if let existedView = window.subviews.first(
                where: {$0 is UIActivityIndicatorView}) as? UIActivityIndicatorView {
                loadingIndicatorView = existedView
            } else { // 새로 만들기.
                loadingIndicatorView = UIActivityIndicatorView(style: .large)
                // 아래는 다른 UI를 클릭하는 것 방지.
                loadingIndicatorView.frame = window.frame
                loadingIndicatorView.color = UIColor(red: 0.40, green: 0.40, blue: 0.67, alpha: 1.00)

                window.addSubview(loadingIndicatorView)
            }
            loadingIndicatorView.startAnimating()
        }
    }

    static func hideLoading() {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: "sound") {
                AudioServicesPlaySystemSound(1057)
            }
            guard let window = UIApplication.shared.windows.last else { return }
            window.subviews.filter({ $0 is UIActivityIndicatorView })
                .forEach { $0.removeFromSuperview() }
        }
    }
}
