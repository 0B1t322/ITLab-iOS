//
// PlaceSalaryEdit.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct PlaceSalaryEdit: Codable {

    public var placeId: UUID?
    public var count: Int?
    public var _description: String?

    public init(placeId: UUID? = nil, count: Int? = nil, _description: String? = nil) {
        self.placeId = placeId
        self.count = count
        self._description = _description
    }

    public enum CodingKeys: String, CodingKey { 
        case placeId
        case count
        case _description = "description"
    }

}
