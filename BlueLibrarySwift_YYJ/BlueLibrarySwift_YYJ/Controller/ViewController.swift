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
    
    fileprivate var scrollWidth: CGFloat = 280
    fileprivate let scrollHight: CGFloat = 150
    fileprivate let thumbNailWidth: CGFloat = 120
    fileprivate let thumbNailHeight: CGFloat = 120
    fileprivate let padding: CGFloat = 10
    
    var albumDataList: [MusicInfo] = []
    
    @IBOutlet weak var albumTableView: UITableView!
    
    fileprivate func loadTableView() {
        self.albumTableView.delegate = self
        self.albumTableView.dataSource = self
    }
    
    fileprivate func makeScrollView() {
        let imageStrings: [String] = ["image01","image02","image03","image04","image05","image06","image07"]
        scrollWidth = self.view.frame.width
        
        // scroll view setting
        albumScrollView = UIScrollView(frame: CGRectMake(0, 0 + scrollHight - 40, scrollWidth, scrollHight))
        
        let contentSizeWidth:CGFloat = (thumbNailWidth + padding) * (CGFloat(imageStrings.count))
        let contentSize = CGSize(width: contentSizeWidth, height: thumbNailHeight)
        
        albumScrollView.contentSize = contentSize
        albumScrollView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        
        for (index, value) in imageStrings.enumerated() {
            let button:UIButton = UIButton(type: .custom)
            var xButton = CGFloat(padding * (CGFloat(index) + 1) + (CGFloat(index) * thumbNailWidth))
            button.frame = CGRectMake(xButton, padding, thumbNailWidth, thumbNailHeight)
            button.tag = index
            
            let image = UIImage(named: value)
            button.setBackgroundImage(image, for: .normal)
            albumScrollView.addSubview(button)
        }
        self.view.addSubview(albumScrollView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BlueLibrary YYJ"
        self.albumDataList = loadJson(jsonFileName, fileExtention)
        loadTableView()
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

