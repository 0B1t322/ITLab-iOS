//
//  UserRealm.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 20.09.2021.
//

import Foundation
import RealmSwift

final class UserRealm: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var middleName: String?
    @Persisted var phoneNumber: String?
    @Persisted var email: String
    @Persisted var properties: List<UserPropertyViewRealm>
    
    convenience init(user: UserView) {
        self.init()
        
        self.id = user._id!
        self.firstName = user.firstName ?? ""
        self.middleName = user.middleName
        self.lastName = user.lastName ?? ""
        self.phoneNumber = user.phoneNumber
        self.email = user.email!
        user.properties?.forEach {
            self.properties.append(UserPropertyViewRealm($0))
        }
    }
}

class UserPropertyViewRealm: Object {
    @Persisted var value: String?
    @Persisted var status: String?
    @Persisted var userPropertyType: UserPropertyTypeViewRealm?
    
    convenience init(_ property: UserPropertyView) {
        self.init()
        
        self.value = property.value
        self.status = property.status
        if let propertyType = property.userPropertyType {
            self.userPropertyType = UserPropertyTypeViewRealm(propertyType)
        }
    }
}

class UserPropertyTypeViewRealm: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var descript: String?
    @Persisted var instancesCount: Int?
    @Persisted var isLocked: Bool?
    
    convenience init(_ propertyType: UserPropertyTypeView) {
        self.init()
        self.id = propertyType._id!
        self.title = propertyType.title!
        self.descript = propertyType._description
        self.instancesCount = propertyType.instancesCount
        self.isLocked = propertyType.isLocked
    }
}
