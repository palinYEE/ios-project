//
//  ListTableViewCell.swift
//  YYJ_ClassicPhotos
//
//  Created by yoon-yeoungjin on 2022/11/26.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var imageTitleLalbe: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
