//
//  ViewController.swift
//  multi_level_tableView
//
//  Created by yoon-yeoungjin on 2022/12/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var multiLevelTableView: UITableView!
    var sampleData: [Any] = []
    
    func makeSampleData(){
        var resultData: [sampleModel_level1] = [.init(dataString: "1-1", childData: []), .init(dataString: "2-1", childData: []), .init(dataString: "3-1", childData: [])]
        
        for i in 0..<resultData.count {
            resultData[i].childData.append(.init(dataString: "\(i+1)-1-1", childData: []))
            resultData[i].childData.append(.init(dataString: "\(i+1)-1-2", childData: []))
            resultData[i].childData.append(.init(dataString: "\(i+1)-1-3", childData: []))
            for j in 0..<resultData[i].childData.count {
                resultData[i].childData[j].childData.append(.init(dataString: "\(i+1)-1-\(j+1)-1"))
                resultData[i].childData[j].childData.append(.init(dataString: "\(i+1)-1-\(j+1)-2"))
                resultData[i].childData[j].childData.append(.init(dataString: "\(i+1)-1-\(j+1)-3"))
            }
        }
        
        self.sampleData = resultData
        self.multiLevelTableView.reloadData()
    }
    
    func loadTableView() {
        self.multiLevelTableView.delegate = self
        self.multiLevelTableView.dataSource = self
    }
    override func viewDidLoad() {
        self.title = "Multi Level TableView"
        super.viewDidLoad()
        loadTableView()
        makeSampleData()
        // Do any additional setup after loading the view.
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: multiLevelTableViewCell?
        let member = self.sampleData[indexPath.row]
        
        if let level1 = member as? sampleModel_level1 {
            cell = (tableView.dequeueReusableCell(withIdentifier: "Level1", for: indexPath) as! multiLevelTableViewCell)
            cell?.data.text = level1.dataString
        }
        else if let level2 = member as? sampleModel_level2 {
            cell = (tableView.dequeueReusableCell(withIdentifier: "Level2", for: indexPath) as! multiLevelTableViewCell)
            cell?.data.text = level2.dataString
        } else if let level3 = member as? sampleModel_level3 {
            cell = (tableView.dequeueReusableCell(withIdentifier: "Level3", for: indexPath) as! multiLevelTableViewCell)
            cell?.data.text = level3.dataString
        } else {
            return UITableViewCell()
        }
       
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let member = self.sampleData[row]
        var ipsArr: [IndexPath] = []
        if var level1 = member as? sampleModel_level1 {
            if !level1.isExpanede {
                level1.isExpanede = true
                for (index, value) in level1.childData.enumerated() {
                    self.sampleData.insert(value, at: row + index + 1)
                    let ip = IndexPath(row: row + index + 1, section: 0)
                    ipsArr.append(ip)
                }
                self.sampleData[row] = level1
                tableView.beginUpdates()
                tableView.insertRows(at: ipsArr, with: .left)
                tableView.endUpdates()
            } else {
                level1.isExpanede = false
                var count = 1
                while row + 1 < self.sampleData.count {
                    let element = self.sampleData[row + 1]
                    if element is sampleModel_level2
                    {
                        self.sampleData.remove(at: row + 1)
                        let ip = IndexPath(row: row + count, section: 0)
                        ipsArr.append(ip)
                        count += 1
                        
                    }
                    else if !(element is sampleModel_level2)
                    {
                        break
                    }
                }
                self.sampleData[row] = level1
                tableView.beginUpdates()
                tableView.deleteRows(at: ipsArr, with: .right)
                tableView.endUpdates()
                
            }
        } else if var level2 = member as? sampleModel_level2 {
            if !level2.isExpanede {
                level2.isExpanede = true
                for (index, value) in level2.childData.enumerated() {
                    self.sampleData.insert(value, at: row + index + 1)
                    let ip = IndexPath(row: row + index + 1, section: 0)
                    ipsArr.append(ip)
                }
                self.sampleData[row] = level2
                tableView.beginUpdates()
                tableView.insertRows(at: ipsArr, with: .left)
                tableView.endUpdates()
            } else {
                level2.isExpanede = false
                var count = 1
                while row + 1 < self.sampleData.count {
                    let element = self.sampleData[row + 1]
                    if element is sampleModel_level3
                    {
                        self.sampleData.remove(at: row + 1)
                        let ip = IndexPath(row: row + count, section: 0)
                        ipsArr.append(ip)
                        count += 1
                        
                    }
                    else if !(element is sampleModel_level3)
                    {
                        break
                    }
                }
                self.sampleData[row] = level2
                tableView.beginUpdates()
                tableView.deleteRows(at: ipsArr, with: .right)
                tableView.endUpdates()
            }
        }
    }
}
