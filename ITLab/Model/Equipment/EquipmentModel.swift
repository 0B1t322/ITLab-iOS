//
//  EquipmentModel.swift
//  ITLab
//
//  Created by Даниил on 10.07.2021.
//

import Foundation

struct EquipmentModel: Codable {
    var id: String
    var serialNumber: String
    var description: String?
    var number: Int
    var equipmentTypeId: String
    var equipmentType: EquipmentTypeModel
    var ownerId: String?
    var parentId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case serialNumber
        case description
        case number
        case equipmentTypeId
        case equipmentType
        case ownerId
        case parentId
    }
    
    init(id: String, serialNumber: String, description: String? = nil, number: Int, equipmentTypeId: String, equipmentType: EquipmentTypeModel, ownerId: String? = nil, parentId: String? = nil) {
        self.id = id
        self.serialNumber = serialNumber
        self.description = description
        self.number = number
        self.equipmentTypeId = equipmentTypeId
        self.equipmentType = equipmentType
        self.ownerId = ownerId
        self.parentId = parentId
    }
    
    init(serialNumber: String, equipmentTypeID: String) {
        self.id = ""
        self.serialNumber = serialNumber
        self.description = ""
        self.equipmentTypeId = equipmentTypeID
        self.number = 0
        self.equipmentType = EquipmentTypeModel()
    }
}
