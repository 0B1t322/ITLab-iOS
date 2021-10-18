//
//  EquipmentsTypeObservable.swift
//  ITLab
//
//  Created by Даниил on 15.07.2021.
//

import Foundation

class EquipmentsTypeObservable: ObservableObject {
    @Published var equipmentsType: [EquipmentTypeModel] = []
    
    #if targetEnvironment(simulator)
    func getEquipmentType() {
        for index in 1...20 {
            self.equipmentsType.append(
                EquipmentTypeModel(id: "mock_id_\(index)", title: "mock_title_\(index)", description: "mock_description_\(index)")
            )
        }
    }
    #else
    func getEquipmentType() {
    // Some api styff
    }
    #endif
}
