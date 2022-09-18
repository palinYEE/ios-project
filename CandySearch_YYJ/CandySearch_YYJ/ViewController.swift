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
    
    let scopeButtonTitleList: [String] = [
        "All", "Chocolate", "Hard", "Other"
      ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Candy Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true // Large title로 하고싶을 때 추가
        
        candyTableView.delegate = self
        candyTableView.dataSource = self
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = scopeButtonTitleList

        searchController.searchBar.showsScopeBar = true /* 항상 scope bar 를 보이게 하는 옵션 */
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        
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
        
        let nib = UINib(nibName: "CandyTableViewCell", bundle: nil)
        self.candyTableView.register(nib, forCellReuseIdentifier: "CandyTableViewCell")

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
        return cell
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
