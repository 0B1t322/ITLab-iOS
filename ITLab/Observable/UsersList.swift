//
//  UsersList.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 25.05.2021.
//

import SwiftUI
import Foundation
import CallKit
import RealmSwift

final class UsersListObservable: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var users: [UserRealm] = []
    
    func loadData(callback: (([UserRealm]) -> Void)?) {
        do {
            let realm = try RealmService().realm
            self.users = realm.objects(UserRealm.self)
                .sorted(by: {$0.lastName < $1.lastName})
            
            if users.isEmpty {
                getUsers(callback: callback)
            } else {
                
                if let callback = callback {
                    callback(self.users)
                }
                
                self.isLoading = false
                
                DispatchQueue.main.async {
                    self.getUsersUpdate()
                    
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                
                CXCallDirectoryManager.sharedInstance
                    .getEnabledStatusForExtension(withIdentifier: "ru.RTUITLab.ITLab.ITLab-IICall") { status, error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }

                    switch status {
                    case .enabled:
                        do {
                            try self.saveCallData()
                            
                            CXCallDirectoryManager.sharedInstance
                                .reloadExtension(withIdentifier: "ru.RTUITLab.ITLab.ITLab-IICall") {
                                    if let error = $0 {
                                        print(error.localizedDescription)
                                    }
                                }
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    default:
                        break
                    }
                }
                
            }
            
        } catch {
            print("Not realm loading")
            
            getUsers(callback: callback)
        }
    }
    
    func getUsersUpdate() {
        UserAPI.apiUserGet(count: -1) { (users, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let users = users else {
                print("Not data")
                return
            }
            
            self.users = users.filter {$0.lastName != nil}.map {
                UserRealm(user: $0)
            }
            
            do {
                let realm = try RealmService().realm
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
        }
    }
    
    func getUsers(callback: (([UserRealm]) -> Void)?) {
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
            
            users.filter {$0.lastName != nil}.forEach {
                self.users.append(UserRealm(user: $0))
            }
            
            do {
                let realm = try RealmService().realm
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
                callback(self.users)
            }
            
            self.isLoading = false
        }
    }
    
}

extension UsersListObservable {
    func saveCallData() throws {
        let users = self.users.filter({$0.phoneNumber != nil})
        
        if users.isEmpty {
            return
        }
        
        let result = getUserPhoneArray(users: users)
        
        let contactRealm = try RealmService.getUserContactRealm()
        try contactRealm.write {
            contactRealm.deleteAll()
            result.forEach {
                
                contactRealm.create(UsersPhoneRealm.self,
                                    value: $0,
                                    update: .all)
            }
        }
    }
    
    func getUserPhoneArray(users: [UserRealm]) -> [UsersPhoneRealm] {
        
        var reapetPhone: [String] = []
        
        var result: [UsersPhoneRealm] = []
        var label: String = ""
        for user in users {
            
            if reapetPhone.contains(user.phoneNumber!) {
                continue
            }
            
            let reapetUser = users.filter({
                $0.phoneNumber! == user.phoneNumber!
            })
            
            if reapetUser.count > 1 {
                
                reapetPhone.append(user.phoneNumber!)
                
                label = "\(user.lastName) \(user.firstName) \(user.middleName ?? "") и еще \(declensionContacts(reapetUser.count - 1))"
            } else {
                label = "\(user.lastName) \(user.firstName) \(user.middleName ?? "")"
            }
            
            result.append(UsersPhoneRealm(label: label, phone: CXCallDirectoryPhoneNumber(user.phoneNumber!)!))
        }
        
        return result
    }
    
    func declensionContacts(_ count: Int) -> String {
        
        if count % 10 == 1 &&
            count % 100 != 11 {
            
            return "\(count) контакт"
        } else if (count % 10 >= 2 &&
                   count % 10 <= 4)
                    &&
                    !(count % 100 >= 12 &&
                      count % 100 <= 14) {
            
            return "\(count) контакта"
        } else if count % 10 == 0
                    ||
                    (count % 10 >= 5 &&
                     count % 10 <= 9)
                    ||
                    (count % 100 >= 11 &&
                     count % 100 <= 14) {
            
            return "\(count) контактов"
        }
        
        return "\(count) контакт"
    }
    
}
