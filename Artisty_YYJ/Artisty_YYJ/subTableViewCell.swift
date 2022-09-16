//
//  subTableViewCell.swift
//  Artisty_YYJ
//
//  Created by yoon-yeoungjin on 2022/09/12.
//

import UIKit

class subTableViewCell: UITableViewCell {

    @IBOutlet weak var subArtistInfo: UILabel!
    @IBOutlet weak var subArtistName: UILabel!
    @IBOutlet weak var subArtistImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
