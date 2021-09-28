//
//  RealmService.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 27.09.2021.
//

import Foundation
import RealmSwift

class RealmService {
    
    let realm: Realm
    
    init() throws {
        realm = try Realm()
    }
    
    static func getUserContactRealm() throws -> Realm {
        return try Realm(configuration: Realm.Configuration(fileURL: FileManager
                                                                .default
                                                                .containerURL(forSecurityApplicationGroupIdentifier:
                                                                                "group.ru.RTUITLab.ITLab.db")!
                                                                .appendingPathComponent("contact.realm"),
                                                            objectTypes: [UsersPhoneRealm.self]))
    }
}
