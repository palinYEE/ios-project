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
    
    var albumScrollView: UIScrollView!
    
    /* scroll View frame Setting */
    fileprivate var scrollWidth: CGFloat = 280
    fileprivate let scrollHight: CGFloat = 150
    fileprivate let thumbNailWidth: CGFloat = 120
    fileprivate let thumbNailHeight: CGFloat = 120
    fileprivate let padding: CGFloat = 10
    
    /* tableView cell Data */
    fileprivate var tableViewArtistData: String = ""
    fileprivate var tableViewAlbumData: String = ""
    fileprivate var tableViewGenreData: String = ""
    fileprivate var tableViewYearData: String = ""
    
    var albumDataList: [MusicInfo] = []
    
    @IBOutlet weak var albumTableView: UITableView!
    
    fileprivate func loadTableViewDataSetting(_ index: Int) {
        self.tableViewArtistData = albumDataList[index].Artist
        self.tableViewAlbumData = albumDataList[index].Album
        self.tableViewGenreData = albumDataList[index].Genre
        self.tableViewYearData = String(albumDataList[index].Year)
    }
    
    fileprivate func loadTableView() {
        self.albumTableView.delegate = self
        self.albumTableView.dataSource = self
    }
    
    fileprivate func makeScrollView() {
        scrollWidth = self.view.frame.width
        
        // scroll view setting
        albumScrollView = UIScrollView(frame: CGRectMake(0, 0 + scrollHight - 40, scrollWidth, scrollHight))
        
        let contentSizeWidth:CGFloat = (thumbNailWidth + padding) * (CGFloat(albumDataList.count))
        let contentSize = CGSize(width: contentSizeWidth, height: thumbNailHeight)
        
        albumScrollView.contentSize = contentSize
        albumScrollView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        
        for (index, value) in albumDataList.enumerated() {
            let button:UIButton = UIButton(type: .custom)
            let xButton = CGFloat(padding * (CGFloat(index) + 1) + (CGFloat(index) * thumbNailWidth))
            button.frame = CGRectMake(xButton, padding, thumbNailWidth, thumbNailHeight)
            button.tag = index
            
            
            let url = URL(string: value.ImageUrl)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        button.setBackgroundImage(image, for: .normal)
                        self.albumScrollView.addSubview(button)
                        button.addTarget(self, action: #selector(self.changeTableViewInfo(sender:)), for: .touchUpInside)
                        
                    }
                } else {
                    let image = UIImage(named: "noAlbum")
                    DispatchQueue.main.async {
                        button.setBackgroundImage(image, for: .normal)
                        self.albumScrollView.addSubview(button)
                        button.addTarget(self, action: #selector(self.changeTableViewInfo(sender:)), for: .touchUpInside)
                    }
                }
            }

        }
        self.view.addSubview(albumScrollView)
    }
    
    @objc func changeTableViewInfo(sender:UIButton) {
        // sender.tag : 해당 엘범의 index 값
        loadTableViewDataSetting(sender.tag)
        self.albumTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BlueLibrary YYJ"
        self.albumDataList = loadJson(jsonFileName, fileExtention)
        loadTableView()
        loadTableViewDataSetting(0)
        makeScrollView()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumDataList[0].elementCount()
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* Sample */
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumInfoTableViewCell", for: indexPath) as! albumInfoTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.infoTitle.text = "Artist"
            cell.infoDetail.text = self.tableViewArtistData
            break
        case 1:
            cell.infoTitle.text = "Album"
            cell.infoDetail.text = self.tableViewAlbumData
            break
        case 2:
            cell.infoTitle.text = "Genre"
            cell.infoDetail.text = self.tableViewGenreData
            break
        case 3:
            cell.infoTitle.text = "Year"
            cell.infoDetail.text = self.tableViewYearData
            break
        default:
            break
        }
        
        return cell
        
    }
    
    
}

