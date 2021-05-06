//
// UserPropertyTypeCreateRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

public struct UserPropertyTypeCreateRequest: Codable {

    public var title: String
    public var _description: String?
    public var defaultStatus: String?

    public init(title: String, _description: String?, defaultStatus: String?) {
        self.title = title
        self._description = _description
        self.defaultStatus = defaultStatus
    }

    public enum CodingKeys: String, CodingKey {
        case title
        case _description = "description"
        case defaultStatus
    }

}
