//
//  ViewController.swift
//  CandySearch_YYJ
//
//  Created by yoon-yeoungjin on 2022/09/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var candyTableView: UITableView!
    var candies: [Candy] = []
    var filterCandies: [Candy] = []
    var filterCandies2: [Candy] = []
    
    /* scope button title list */
    let scopeButtonTitleList: [String] = [
        "All", "Chocolate", "Hard", "Other"
      ]
    
    
    /* navigation setting */
    func navigationSetting() {
        self.navigationItem.title = "Candy Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true // Large title로 하고싶을 때 추가
    }
    
    /* table view setting */
    func tableViewSetting() {
        candyTableView.delegate = self
        candyTableView.dataSource = self
    }
    
    /* ui search controller setting */
    func uiSearchControllerSetting() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = scopeButtonTitleList

        searchController.searchBar.showsScopeBar = true /* 항상 scope bar 를 보이게 하는 옵션 */
        searchController.obscuresBackgroundDuringPresentation = false   /* 검색시 백그라운드를 비활성화 처리 */
        
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
    }
    
    /* candies Data Setting */
    func candiesDataSetting() {
        candies = [
            Candy(category:"Chocolate", name:"Chocolate Bar"),
            Candy(category:"Chocolate", name:"Chocolate Chip"),
            Candy(category:"Chocolate", name:"Dark Chocolate"),
            Candy(category:"Hard", name:"Lollipop"),
            Candy(category:"Hard", name:"Candy Cane"),
            Candy(category:"Hard", name:"Jaw Breaker"),
            Candy(category:"Other", name:"Caramel"),
            Candy(category:"Other", name:"Sour Chew"),
            Candy(category:"Other", name:"Gummi Bear")
        ]
        filterCandies = candies
        filterCandies2 = candies
    }
    
    func doSetting() {
        navigationSetting()
        tableViewSetting()
        uiSearchControllerSetting()
        candiesDataSetting()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CandyTableViewCell", bundle: nil)
        self.candyTableView.register(nib, forCellReuseIdentifier: "CandyTableViewCell")

    }
    
    /* segue 에 등록한 storyboard 에 데이터를 전달한다. */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? subViewController, let indexPath = candyTableView.indexPathForSelectedRow {
            destination.CandyImageString = filterCandies2[indexPath.row].name
            destination.CandyNameLabelString = filterCandies2[indexPath.row].name
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterCandies2.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CandyTableViewCell", for: indexPath) as! CandyTableViewCell
        cell.CandyName.text = filterCandies2[indexPath.row].name
        cell.category.text = filterCandies2[indexPath.row].category
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCandy", sender: nil)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.filterCandies2 = self.filterCandies.filter { $0.name.lowercased().hasPrefix(text.lowercased()) }
        self.candyTableView.reloadData()
    }
}


extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if selectedScope > 0 {
            let text = scopeButtonTitleList[selectedScope]
            self.filterCandies = self.candies.filter { $0.category.lowercased().hasPrefix(text.lowercased()) }
            self.filterCandies2 = filterCandies
        } else {
            self.filterCandies = self.candies
            self.filterCandies2 = filterCandies
        }
    }
}
