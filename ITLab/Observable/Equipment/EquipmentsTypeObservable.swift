//
//  EquipmentsTypeObservable.swift
//  ITLab
//
//  Created by Даниил on 15.07.2021.
//

import Foundation

class EquipmentsTypeObservable: ObservableObject {
    @Published var equipmentsType: [CompactEquipmentTypeView] = []
    
    func getEquipmentType() {
        EquipmentTypeAPI.apiEquipmentTypeGet { (equipmentsType, error) in
            if let error = error {
                print(error)
                return
            }
            self.equipmentsType = equipmentsType ?? []
        }
    }
}
