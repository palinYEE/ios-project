//
//  MenuViewController.swift
//  Tumblr_YYJ
//
//  Created by yoon-yeoungjin on 2022/11/19.
//

import UIKit

class MenuViewController: UIViewController {
    let transitionManager = TranstitionManager()

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textImage: UIImageView!
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoLabel: UILabel!
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var quoteImage: UIImageView!
    
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var linkImage: UIImageView!
    
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatLabel: UILabel!
    
    @IBOutlet weak var audioLabel: UILabel!
    @IBOutlet weak var audioImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self.transitionManager

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
   
}
