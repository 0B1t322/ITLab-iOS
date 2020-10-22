//
// EquipmentEditRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct EquipmentEditRequest: Codable {

    public var serialNumber: String?
    public var equipmentTypeId: UUID?
    public var _description: String?
    public var parentId: UUID?
    public var delete: Bool?
    public var _id: UUID

    public init(serialNumber: String?, equipmentTypeId: UUID?, _description: String?, parentId: UUID?, delete: Bool?, _id: UUID) {
        self.serialNumber = serialNumber
        self.equipmentTypeId = equipmentTypeId
        self._description = _description
        self.parentId = parentId
        self.delete = delete
        self._id = _id
    }

    public enum CodingKeys: String, CodingKey { 
        case serialNumber
        case equipmentTypeId
        case _description = "description"
        case parentId
        case delete
        case _id = "id"
    }

}

