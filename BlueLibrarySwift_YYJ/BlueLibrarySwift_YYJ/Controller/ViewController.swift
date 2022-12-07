//
//  ViewController.swift
//  BlueLibrarySwift_YYJ
//
//  Created by yoon-yeoungjin on 2022/12/06.
//

import UIKit

class ViewController: UIViewController {
    fileprivate let jsonFileName:String = "albums"
    fileprivate let fileExtention: String = "json"
    
    var albumDataList: [MusicInfo] = []
    
    @IBOutlet weak var albumTableView: UITableView!
    
    fileprivate func loadTableView() {
        self.albumTableView.delegate = self
        self.albumTableView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.albumDataList = loadJson(jsonFileName, fileExtention)
        loadTableView()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumDataList[0].elementCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* Sample */
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumInfoTableViewCell", for: indexPath) as! albumInfoTableViewCell
        
        print(self.albumDataList)
        
        switch indexPath.row {
        case 0:
            cell.infoTitle.text = "Artist"
            cell.infoDetail.text = self.albumDataList[0].Artist
            break
        case 1:
            cell.infoTitle.text = "Album"
            cell.infoDetail.text = self.albumDataList[0].Album
            break
        case 2:
            cell.infoTitle.text = "Genre"
            cell.infoDetail.text = self.albumDataList[0].Genre
            break
        case 3:
            cell.infoTitle.text = "Year"
            cell.infoDetail.text = String(self.albumDataList[0].Year)
            break
        default:
            break
        }
        
        return cell
        
    }
    
    
}

