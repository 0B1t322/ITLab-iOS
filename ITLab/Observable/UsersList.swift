//
//  UsersList.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 25.05.2021.
//

import SwiftUI
import RealmSwift

final class UsersListObservable: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var users: [UserView] = []
    
    func getUsers() {
        UserAPI.apiUserGet(count: -1) { (users, error) in
            
            if let error = error {
                print(error)
                self.isLoading = false
                return
            }
            
            guard let users = users else {
                print("Not data")
                self.isLoading = false
                return
            }
            DispatchQueue.main.async {
                
                do {
                    let realm = try Realm()
                    try realm.write {
                        users.filter {$0.lastName != nil}.forEach {
                            realm.create(UserRealm.self,
                                         value: UserRealm(user: $0),
                                         update: .modified)
                        }
                    }
                } catch {
                    print("Realm fail")
                }
                
                self.users = users.filter {$0.lastName != nil}
                self.users.sort {
                    $0.lastName ?? "" < $1.lastName ?? ""
                }
                self.isLoading = false
            }
        }
    }
}
