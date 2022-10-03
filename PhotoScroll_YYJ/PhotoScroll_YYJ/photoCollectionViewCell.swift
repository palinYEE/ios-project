//
//  photoCollectionViewCell.swift
//  PhotoScroll_YYJ
//
//  Created by yoon-yeoungjin on 2022/10/03.
//

import UIKit

class photoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    
    func imageLoad(imageName: String) {
        photo.image = UIImage(named: imageName)
    }
}
