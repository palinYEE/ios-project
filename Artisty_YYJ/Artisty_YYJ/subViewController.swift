//
//  subViewController.swift
//  Artisty_YYJ
//
//  Created by yoon-yeoungjin on 2022/09/12.
//

import UIKit

class subViewController:UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var selectedArtist: Artist!
    
    let moreInfoText = "Select For More Into >"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedArtist.name
        
        tableview.delegate = self
        tableview.dataSource = self
        let nib = UINib(nibName: "subTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "subTableViewCell")
    }
}

extension subViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArtist.works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subTableViewCell", for: indexPath) as! subTableViewCell
        let work = selectedArtist.works[indexPath.row]
        
        cell.subArtistImage.image = work.image
        cell.subArtistInfo.text = work.info
        cell.subArtistName.text = work.title
        
        cell.subArtistName.backgroundColor = UIColor(white: 204/255, alpha: 1)
        cell.subArtistName.textAlignment = .center
        cell.subArtistInfo.textColor = UIColor(white: 114/255, alpha: 1)
        cell.selectionStyle = .none
        
        cell.subArtistInfo.text = work.isExpanded ? work.info : moreInfoText
        cell.subArtistInfo.textAlignment = work.isExpanded ? .left : .center
        
        cell.subArtistName.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cell.subArtistInfo.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? subTableViewCell else { return }
        
        var work = selectedArtist.works[indexPath.row]
        
        work.isExpanded = !work.isExpanded
        selectedArtist.works[indexPath.row] = work
        
        cell.subArtistInfo.text = work.isExpanded ? work.info : moreInfoText
        cell.subArtistInfo.textAlignment = work.isExpanded ? .left : .center
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
