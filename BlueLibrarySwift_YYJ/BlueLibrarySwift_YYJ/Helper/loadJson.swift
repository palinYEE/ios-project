//
//  loadJson.swift
//  BlueLibrarySwift_YYJ
//
//  Created by yoon-yeoungjin on 2022/12/07.
//

import Foundation

/**
 json 파일을 읽어서 MusicInfo 구조체로 변환시켜주는 함수
 */
func loadJson(_ jsonFileName: String, _ fileExtention: String) -> [MusicInfo] {
    let funcName: String = "loadJson"
    var resultList: [MusicInfo] = []
    
    guard let url = Bundle.main.url(forResource: jsonFileName, withExtension: fileExtention) else {return resultList}
    
    do {
        let data = try Data(contentsOf: url)
        guard let objects = try JSONSerialization.jsonObject(with: data) as? [[String: String]] else {return resultList}
        
        for object in objects {
            if let title = object["title"],
               let artist = object["artist"],
               let genre = object["genre"],
               let converUrl = object["coverUrl"],
               let year = object["year"] {
                let data: MusicInfo = .init(Artist: artist, Album: title, Genre: genre, Year: Int(year) ?? 0, ImageUrl: converUrl)
                resultList.append(data)
            } else {
                print("[\(funcName)](Error) - load json file")
            }
        }
        
    } catch {
        print("[\(funcName)](Error) - parse Data ")
        return resultList
    }
    
    return resultList
}
