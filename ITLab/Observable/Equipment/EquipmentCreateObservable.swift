//
//  EquipmentObservable.swift
//  ITLab
//
//  Created by Даня Демин on 12.07.2021.
//

import Foundation

final class EquipmentCreateObservable: ObservableObject {
    @Published var serialNumber: String?
    @Published var equipmentTypeId: UUID?
    @Published var description: String?
    
    enum CreateStatus: Int {
        case created = 201
        case serialNumberExist = 409
        case equipmentTypeNotFound = 404
        case unexpected
    }
    
    func createEquipment() -> CreateStatus? {
        var createStatus: CreateStatus?
        EquipmentAPI.apiEquipmentPost(body: EquipmentCreateRequest.init(serialNumber: serialNumber, equipmentTypeId: equipmentTypeId, _description: description, children: nil)) {
            equipment, error in
            if let error = error {
                if let code = error.asAFError?.responseCode {
                    createStatus = CreateStatus.init(rawValue: code) ?? .unexpected
                }
            }
        }
        return createStatus
    }
}
