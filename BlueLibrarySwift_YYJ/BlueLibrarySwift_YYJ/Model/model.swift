//
//  model.swift
//  BlueLibrarySwift_YYJ
//
//  Created by yoon-yeoungjin on 2022/12/06.
//

enum imageLoadType {
    case noUrl
    case loadingUrl
    case finishUrl
}

/**
 해당 프로젝트의 데이터 구조체 입니다.
 */
struct MusicInfo {
    let Artist: String
    let Album: String
    let Genre: String
    let Year: Int
    let ImageUrl: String
    var ImageLoadType: imageLoadType
    
    init(Artist: String, Album: String, Genre: String, Year: Int, ImageUrl: String) {
        self.Artist = Artist
        self.Album = Album
        self.Genre = Genre
        self.Year = Year
        self.ImageUrl = ImageUrl
        self.ImageLoadType = .loadingUrl
    }

    func elementCount() -> Int{
        return 4
    }
}
