//
//  UserObservable.swift
//  ITLab
//
//  Created by Даня Демин on 12.07.2021.
//

import Foundation
import SwiftUI

final class UserObservable: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var user: UserView?
    
    func getUser(userId: UUID) {
        self.isLoading = true
        defer {
            self.isLoading = false
        }
        UserAPI.apiUserIdGet(_id: userId) { (user, error) in
            if let error = error {
                print(error)
                return
            }
            self.user = user ?? nil
        }
    }
    
    func getFullName() -> String? {
        if let firstName = user?.firstName, let lastName = user?.lastName {
            return "\(firstName) \(lastName)"
        } else {
            return nil
        }
    }
    
    func getFullNameWithEmail() -> String? {
        let fullName = self.getFullName()
        
        if let fullName = self.getFullName(), let email = user?.email {
            return "\(fullName), \(email)"
        } else {
            return nil
        }
    }
}
