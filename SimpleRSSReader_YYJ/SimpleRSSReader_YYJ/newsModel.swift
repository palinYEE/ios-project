//
//  newsModel.swift
//  SimpleRSSReader_YYJ
//
//  Created by yoon-yeoungjin on 2022/09/24.
//

import Foundation

struct appleNews {
    var head: String
    var uploadDate: String
    var description: String
    var isExtend: Bool
    
    init(head: String, uploadDate: String, description: String, isExtend: Bool) {
        self.head = head
        self.uploadDate = uploadDate
        self.description = description
        self.isExtend = isExtend
    }
}
