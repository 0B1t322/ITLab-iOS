//
// CompactEquipmentTypeView.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

public struct CompactEquipmentTypeView: Codable {

    public var _id: UUID?
    public var title: String?
    public var shortTitle: String?
    public var _description: String?
    public var rootId: UUID?
    public var parentId: UUID?

    public init(_id: UUID?, title: String?, shortTitle: String?, _description: String?, rootId: UUID?, parentId: UUID?) {
        self._id = _id
        self.title = title
        self.shortTitle = shortTitle
        self._description = _description
        self.rootId = rootId
        self.parentId = parentId
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case title
        case shortTitle
        case _description = "description"
        case rootId
        case parentId
    }

}
