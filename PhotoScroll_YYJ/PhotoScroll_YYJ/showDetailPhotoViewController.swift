//
//  showDetailPhotoViewController.swift
//  PhotoScroll_YYJ
//
//  Created by yoon-yeoungjin on 2022/10/09.
//

import UIKit

class showDetailPhotoViewController: UIViewController {
    var imageNameString: String = ""
    @IBOutlet weak var imageName: UIImageView!
    override func viewDidLoad() {
        imageName.image = UIImage(named: imageNameString)
        super.viewDidLoad()
    }

}
