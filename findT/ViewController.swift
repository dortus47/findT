//
//  ViewController.swift
//  findT
//
//  Created by 장은석 on 2021/12/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getTest()
    }

    func getTest() {
            let url = "https://jsonplaceholder.typicode.com/todos/1"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type": "application/json", "Accept": "application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { (json) in
                    // 여기서 가져온 데이터를 자유롭게 활용하세요.
                    print(json)
            }
        }
}
