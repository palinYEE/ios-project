//
//  ViewController.swift
//  Tumblr_YYJ
//
//  Created by yoon-yeoungjin on 2022/11/13.
//

import UIKit

class ViewController: UIViewController {
    let transitionManager = TranstitionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after
        navigationController?.toolbar.clipsToBounds = true
    }
    @IBAction func unwindToMainViewController (_ sender: UIStoryboardSegue){
        self.dismiss(animated: true, completion: nil)
    }

 
}

