//
//  StationListTableViewController.swift
//  findT
//
//  Created by 장은석 on 2022/01/04.
//

import UIKit

class StationListTableViewController: UITableViewController {
    
    let list = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ", "N"]
    
    lazy var sorted = Array(FileManager.shared.stationCordinateDictionary.keys)
    
    let colorManager = ColorManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 가장 첫 초성 추출
    func sectionCheck(name: String) -> String {
        if name == "419민주묘지" {
            return "N"
        }
        
        let hangul = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        let octal = name.unicodeScalars[name.unicodeScalars.startIndex].value
        let index = (octal - 0xac00) / 28 / 21
        return hangul[Int(index)]
    }
    
    // MARK: - Table view data source
    
    // 셀 클릭 시, 탭 뷰 이동+ 위치 지정 로직
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = sorted.filter{sectionCheck(name: $0) == list[indexPath.section]}[indexPath.row]
        let referenceForTabBarController = self.tabBarController!
        self.dismiss(animated: true, completion:{
            referenceForTabBarController.selectedIndex = 0
            NotificationCenter.default.post(name: .searchMap, object: name)
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sorted.filter{sectionCheck(name: $0) == list[section]}.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StationListTableViewCell.identifier, for: indexPath) as? StationListTableViewCell else {
            return UITableViewCell()
        }
        let leftText = sorted.filter{sectionCheck(name: $0) == list[indexPath.section]}[indexPath.row]
        let rightText = FileManager.shared.stationCordinateDictionary[leftText]?.line
        let color = colorManager.lineDictionary[rightText!]
        cell.setData(name: leftText, line: rightText!, color: color!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section]
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return stride(from: 0, to: list.count, by: 1).map { list[$0] }
    }
}
