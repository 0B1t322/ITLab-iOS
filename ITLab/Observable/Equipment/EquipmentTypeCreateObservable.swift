//
//  EquipmentTypeObservable.swift
//  ITLab
//
//  Created by Даниил on 15.07.2021.
//

import Foundation

class EquipmentTypeCreateObservable: ObservableObject {
    @Published var title: String = ""
    @Published var description: String?
    @Published var shortTitle: String?
    @Published var parentId: UUID?
    
    func createEquipmentType() -> EquipmentTypeView? {
        var created: EquipmentTypeView? = nil
        EquipmentTypeAPI.apiEquipmentTypePost(body: EquipmentTypeCreateRequest.init(title: title, shortTitle: shortTitle, _description: description, parentId: parentId)) {
            equipmentType, error in
            if let error = error {
                print(error)
                return
            }
            created = equipmentType
        }
        return created
    }
}
