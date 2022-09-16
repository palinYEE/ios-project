//
//  ViewController.swift
//  Artisty_YYJ
//
//  Created by yoon-yeoungjin on 2022/09/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var artistDataList: [Artist] = Artist.artistsFromBundle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Artistry"
        mainTableView.dataSource = self
        mainTableView.delegate = self
        /* mainTableViewCell 을 table view 에 등록 */
        let nib = UINib(nibName: "mainTableViewCell", bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: "mainTableViewCell")
    }
    
    /* segue 에 등록한 storyboard 에 데이터를 전달한다. */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? subViewController, let indexPath = mainTableView.indexPathForSelectedRow {
            destination.selectedArtist = artistDataList[indexPath.row]
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistDataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: indexPath) as! mainTableViewCell
        cell.artistImage.image = artistDataList[indexPath.row].image
        cell.artistName.text = artistDataList[indexPath.row].name
        cell.artistBio.text = artistDataList[indexPath.row].bio
        
        cell.artistBio.textColor = UIColor(white: 114/255, alpha: 1)
        
        cell.artistName.backgroundColor = UIColor(red: 1, green: 152/255, blue: 0, alpha: 1)
        cell.artistName.textColor = .white
        cell.artistName.textAlignment = .center
        cell.selectionStyle = .none
        
        cell.artistName.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.artistBio.font = UIFont.preferredFont(forTextStyle: .body)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowArtist", sender: nil)
    }
}
