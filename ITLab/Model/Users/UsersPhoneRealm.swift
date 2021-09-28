//
//  UsersSlimData.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 27.09.2021.
//

import Foundation
import CallKit
import RealmSwift

final class UsersPhoneRealm: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var label: String
    @Persisted var phoneNumber: CXCallDirectoryPhoneNumber
    
    convenience init(label: String, phone: CXCallDirectoryPhoneNumber) {
        self.init()
        self.label = label
        self.phoneNumber = phone
    }
}
