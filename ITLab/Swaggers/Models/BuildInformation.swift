//
// BuildInformation.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Information about the build */

public struct BuildInformation: Codable {

    /** Build unique id */
    public var buildId: String?
    /** Build Data */
    public var buildDateString: String?

    public init(buildId: String?, buildDateString: String?) {
        self.buildId = buildId
        self.buildDateString = buildDateString
    }


}

