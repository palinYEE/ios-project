//
//  ViewController.swift
//  YYJ_ClassicPhotos
//
//  Created by yoon-yeoungjin on 2022/11/26.
//

import UIKit

let dataSourceURL = URL(string: "https://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist")

class ViewController: UIViewController {
    
    @IBOutlet weak var listTableVie: UITableView!
    var photos = [PhotoRecord]()
    let pendingOperation = PendingOperation()
    
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        self.listTableVie.delegate = self
        self.listTableVie.dataSource = self
        self.navigationItem.title = "Classic Photos"
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchPhotoDetails()
        print(photos)
    }
    
    fileprivate func fetchPhotoDetails() {
        let request = URLRequest(url: dataSourceURL!)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
            if let error = error {
                let alert = UIAlertView(title: "Oops", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                return
            }
            
            if let data = data {
                do {
                    if let dataSourceDictionary = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.ReadOptions(rawValue: 0) ,format:nil) as? [String: AnyObject] {
                        for (name, url) in dataSourceDictionary {
                            if let url = URL(string:url as! String) {
                                let photoRecord = PhotoRecord(name: name, url: url)
                                self.photos.append(photoRecord)
                            }
                        }
                        
                        self.listTableVie.reloadData()
                        
                    }
                } catch let error as NSError {
                    print(error.domain)
                }
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    fileprivate func startOperationForPhotoRecord(photoDetails: PhotoRecord, indexPath: IndexPath) {
        switch(photoDetails.state) {
        case .New:
            startDownloadForRecord(photoDetails: photoDetails, indexPath: indexPath)
        case .Download:
            startFiltrationForRecord(photoDetails: photoDetails, indexPath: indexPath)
        default:
            NSLog("do nothing")
        }
    }
    
    fileprivate func startDownloadForRecord(photoDetails: PhotoRecord, indexPath: IndexPath) {
        if let _ = pendingOperation.downloadsInProgress[indexPath] {
            return
        }
        
        let downloader = ImageDownloader(photoRecord: photoDetails)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            DispatchQueue.main.async {
                self.pendingOperation.downloadsInProgress.removeValue(forKey: indexPath)
                self.listTableVie.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        pendingOperation.downloadsInProgress[indexPath] = downloader
        pendingOperation.downloadQueue.addOperation(downloader)
        
    }
    
    fileprivate func startFiltrationForRecord(photoDetails: PhotoRecord, indexPath: IndexPath) {
        if let _ = pendingOperation.filtrationsInProgress[indexPath] {
            return
        }
        
        let filterer = ImageFiltration(photoRecord: photoDetails)
        filterer.completionBlock = {
            if filterer.isCancelled {
                return
            }
            DispatchQueue.main.async {
                self.pendingOperation.filtrationsInProgress.removeValue(forKey: indexPath)
                self.listTableVie.reloadRows(at: [indexPath], with: .fade)
            }
        }
        pendingOperation.filtrationsInProgress[indexPath] = filterer
        pendingOperation.filtrationQueue.addOperation(filterer)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        if cell.accessoryView == nil {
            let indicator = UIActivityIndicatorView(style: .gray)
            cell.accessoryView = indicator
        }
        let indecator = cell.accessoryView as! UIActivityIndicatorView
        let photoDetails = self.photos[indexPath.row]
        
        cell.imageTitleLalbe.text = photoDetails.name
        cell.photoImage.image = photoDetails.image
        
        switch(photoDetails.state) {
        case .Filtered:
            indecator.stopAnimating()
        case .Failed:
            indecator.stopAnimating()
            cell.imageTitleLalbe.text = "Failed to load"
        case .New, .Download:
            indecator.stopAnimating()
            if (!listTableVie.isDragging && !listTableVie.isDecelerating) {
                self.startOperationForPhotoRecord(photoDetails: photoDetails, indexPath: indexPath)
            }
        }
        return cell
    }
    
    
}
