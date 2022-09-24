//
//  newsTableViewCell.swift
//  SimpleRSSReader_YYJ
//
//  Created by yoon-yeoungjin on 2022/09/24.
//

import UIKit

class newsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsUploadDate: UILabel!
    @IBOutlet weak var newsDescription: UILabel! {
        didSet {
            newsDescription.numberOfLines = 4
        }
    }
}
