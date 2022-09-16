//
//  Artist.swift
//  Artisty_YYJ
//
//  Created by yoon-yeoungjin on 2022/09/12.
//

import UIKit

struct Artist {
    let name: String
    let bio: String
    let image: UIImage
    var works:[Work]
    
    init(name: String, bio: String, image: UIImage, works: [Work]) {
        self.name = name
        self.bio = bio
        self.image = image
        self.works = works
    }
    
    static func artistsFromBundle() -> [Artist] {
        var artists = [Artist]()
        
        guard let url = Bundle.main.url(forResource: "artistry", withExtension: "json") else {return artists}
        
        do {
            let data = try Data(contentsOf: url)
            guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else { return artists }
            guard let artistsObject = rootObject["artists"] as? [[String: AnyObject]] else { return artists }
            
            for object in artistsObject {
                if let name = object["name"] as? String,
                   let bio = object["bio"] as? String,
                   let imageName = object["image"] as? String,
                   let image = UIImage(named: imageName),
                   let worksObject = object["works"] as? [[String: String]] {
                    var works = [Work]()
                    for workObjeck in worksObject {
                        if let workTitle = workObjeck["title"],
                           let workImageName = workObjeck["image"],
                           let workImage = UIImage(named: workImageName + ".jpg"),
                           let info = workObjeck["info"] {
                            works.append(Work(title: workTitle, image: workImage, info: info, isExpanded: false))
                        }
                    }
                    let artist = Artist(name: name, bio: bio, image: image, works:works)
                    artists.append(artist)
                }
            }
            
        } catch {
            return artists
        }
        return artists
    }
}
