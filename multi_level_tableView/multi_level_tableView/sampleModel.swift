//
//  sampleModel.swift
//  multi_level_tableView
//
//  Created by yoon-yeoungjin on 2022/12/18.
//

import Foundation

struct sampleModel_level1 {
    var dataString: String = ""
    var childData: [sampleModel_level2] = []
    var depthLevel: Int = 0
    var isExpanede: Bool?
    var hasChild: Bool?
    
    init(dataString: String, childData: [sampleModel_level2]) {
        self.dataString = dataString
        self.childData = childData
        self.depthLevel = 0
        self.isExpanede = false
        self.hasChild = true
    }
}

struct sampleModel_level2{
    var dataString: String = ""
    var childData: [sampleModel_level3] = []
    var depthLevel: Int = 1
    var isExpanede: Bool?
    var hasChild: Bool?
    
    init(dataString: String, childData: [sampleModel_level3]) {
        self.dataString = dataString
        self.childData = childData
        self.depthLevel = 1
        self.isExpanede = false
        self.hasChild = true
    }
}


struct sampleModel_level3{
    var dataString: String = ""
    var depthLevel: Int = 2
    var isExpanede: Bool?
    var hasChild: Bool?
    
    init(dataString: String) {
        self.dataString = dataString
        self.depthLevel = 2
        self.isExpanede = false
        self.hasChild = true
    }
}
