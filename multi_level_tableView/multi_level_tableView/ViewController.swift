//
//  ViewController.swift
//  multi_level_tableView
//
//  Created by yoon-yeoungjin on 2022/12/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var multiLevelTableView: UITableView!
    var sampleData: [sampleModel_level1] = []
    
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
        let member = self.sampleData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Level1", for: indexPath) as! multiLevelTableViewCell
        cell.data.text = member.dataString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
