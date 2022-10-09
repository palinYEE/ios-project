//
//  detailPhotoViewController.swift
//  PhotoScroll_YYJ
//
//  Created by yoon-yeoungjin on 2022/10/03.
//

import UIKit

class detailPhotoViewController: UIViewController {
    
    var imageNameString: String = ""
    @IBOutlet weak var imageName: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageName.image = UIImage(named: imageNameString)
    }

}
