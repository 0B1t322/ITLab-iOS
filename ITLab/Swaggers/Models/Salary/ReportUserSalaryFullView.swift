//
// ReportUserSalaryFullView.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ReportUserSalaryFullView: Codable {

    public var reportId: String?
    public var approved: Date?
    public var approverId: UUID?
    public var count: Int?
    public var _description: String?

    public init(reportId: String? = nil, approved: Date? = nil, approverId: UUID? = nil, count: Int? = nil, _description: String? = nil) {
        self.reportId = reportId
        self.approved = approved
        self.approverId = approverId
        self.count = count
        self._description = _description
    }

    public enum CodingKeys: String, CodingKey { 
        case reportId
        case approved
        case approverId
        case count
        case _description = "description"
    }

}