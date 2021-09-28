//
//  CallDirectoryHandler.swift
//  ITLab-IICall
//
//  Created by Mikhail Ivanov on 23.09.2021.
//

import Foundation
import CallKit
import RealmSwift

class CallDirectoryHandler: CXCallDirectoryProvider {
    
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        context.delegate = self
        
        context.removeAllIdentificationEntries()
        
        addIdentificationPhoneNumbers(to: context)
        
        context.completeRequest { result in
            print(result)
        }
    }
    
    func addIdentificationPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        
        guard let realm = try? RealmService.getUserContactRealm() else { return }
        let users = realm.objects(UsersPhoneRealm.self).sorted(byKeyPath: "phoneNumber")
        
        for user in users {
            
            context.addIdentificationEntry(withNextSequentialPhoneNumber: user.phoneNumber, label: user.label)
        }
    }
}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate {
    
    func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, withError error: Error) {
        print(error)
    }
    
}
