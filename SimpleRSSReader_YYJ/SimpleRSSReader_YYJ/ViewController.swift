//
//  ViewController.swift
//  SimpleRSSReader_YYJ
//
//  Created by yoon-yeoungjin on 2022/09/24.
//
//  url information : http://www.apple.com/main/rss/hotnews/hotnews.rss

import UIKit

class ViewController: UIViewController, XMLParserDelegate {

    @IBOutlet weak var newsTableView: UITableView!
    
    var parser = newsParser()
    var newsItems: [appleNews] = []
    
    func tableViewSelfRegister() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    func registerNIB() {
        let nib = UINib(nibName: "newsTableViewCell", bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: "newsTableViewCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Apple News"
        
        newsTableView.estimatedRowHeight = 140
        newsTableView.rowHeight = UITableView.automaticDimension
        
        newsTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        
        parser.loadParsing() { [weak self] newsItems in
            self?.newsItems = newsItems
            
            DispatchQueue.main.async {
                self?.newsTableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
        tableViewSelfRegister()
        registerNIB()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableViewCell", for: indexPath) as! newsTableViewCell
        cell.newsDescription.text = newsItems[indexPath.row].description
        cell.newsTitle.text = newsItems[indexPath.row].head
        cell.newsUploadDate.text = newsItems[indexPath.row].uploadDate
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? newsTableViewCell else { return }
        var news = newsItems[indexPath.row]
        
        news.isExtend = !news.isExtend
        newsItems[indexPath.row] = news
        
        tableView.beginUpdates()
        cell.newsDescription.numberOfLines = news.isExtend ? 0 : 4
        tableView.endUpdates()
    }
}
