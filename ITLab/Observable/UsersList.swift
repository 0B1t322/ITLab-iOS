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
    @Published var users: [UserRealm] = []
    
    func loadData(callback: (() -> Void)?) {
        do {
            let realm = try Realm()
            self.users = realm.objects(UserRealm.self)
                .sorted(by: {$0.lastName < $1.lastName})
            
            if users.isEmpty {
                getUsers(callback: callback)
            } else {
                
                if let callback = callback {
                    callback()
                }
                
                self.isLoading = false
            }
            
        } catch {
            print("Not realm loading")
            
            getUsers(callback: callback)
        }
    }
    
    func getUsers(callback: (() -> Void)?) {
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
                
                users.filter {$0.lastName != nil}.forEach {
                    self.users.append(UserRealm(user: $0))
                }
                
                do {
                    let realm = try Realm()
                    try realm.write {
                        self.users.forEach {
                            realm.create(UserRealm.self,
                                         value: $0,
                                         update: .modified)
                        }
                    }
                } catch {
                    print("Realm fail")
                }
                
                self.users.sort {
                    $0.lastName < $1.lastName
                }
                
                if let callback = callback {
                    callback()
                }
                
                self.isLoading = false
            }
        }
    }
}
