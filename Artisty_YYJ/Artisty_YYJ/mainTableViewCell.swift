//
//  mainTableViewCell.swift
//  Artisty_YYJ
//
//  Created by yoon-yeoungjin on 2022/09/12.
//

import UIKit

class mainTableViewCell: UITableViewCell {

    @IBOutlet weak var artistBio: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
