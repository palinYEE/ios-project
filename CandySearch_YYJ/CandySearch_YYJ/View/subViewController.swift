//
//  subViewController.swift
//  CandySearch_YYJ
//
//  Created by yoon-yeoungjin on 2022/09/18.
//

import UIKit

class subViewController: UIViewController {
    
    var CandyNameLabelString: String = ""
    var CandyImageString: String = ""
    
    @IBOutlet weak var candyNameLabel: UILabel!
    @IBOutlet weak var candyImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        candyImage.image = UIImage(named: CandyImageString)
        candyNameLabel.text = CandyNameLabelString
    }
}
