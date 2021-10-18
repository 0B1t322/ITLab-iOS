//
//  EquipmentTypeModel.swift
//  ITLab
//
//  Created by Даниил on 10.07.2021.
//

import Foundation

struct EquipmentTypeModel: Codable {
    var id: String
    var title: String
    var description: String
    var shortTitle: String?
    var rootId: String?
    var parentId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case shortTitle
        case rootId
        case parentId
    }
    
    init(id: String, title: String, description: String, shortTitle: String? = nil, rootId: String? = nil, parentId: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.shortTitle = shortTitle
        self.rootId = rootId
        self.parentId = parentId
    }
    
    init() {
        self.id = ""
        self.title = ""
        self.description = ""
    }
}
