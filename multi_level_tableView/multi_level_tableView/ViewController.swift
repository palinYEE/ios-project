//
//  ViewController.swift
//  multi_level_tableView
//
//  Created by yoon-yeoungjin on 2022/12/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var multiLevelTableView: UITableView!
    
    func loadTableView() {
        self.multiLevelTableView.delegate = self
        self.multiLevelTableView.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
