//
//  EquipmentObservable.swift
//  ITLab
//
//  Created by Даниил on 11.07.2021.
//

import Foundation
import SwiftUI

final class EquipmentsObservable: ObservableObject {
    @Published var equipmentModel: [EquipmentModel] = []
    @Published var loading: Bool = false
    @Published var onlyFree: Bool = false
    @Published var match: String = ""
    
    #if targetEnvironment(simulator)
    func getEquipment() {
        equipmentModel = []
        
        if self.equipmentModel.isEmpty {
            self.loading = true
        }
        
        if self.match == "mock_serial_number" {
            let index = 1
            equipmentModel.append(
                EquipmentModel(
                    id: "mock_id_\(index)",
                    serialNumber: "mock_serial_number_\(index)",
                    number: index,
                    equipmentTypeId: "mock_equipment_type_id_\(index)",
                    equipmentType: EquipmentTypeModel(
                        id: "mock_id_\(index)",
                        title: "mock_title_\(index)",
                        description: "mock_description_\(index)",
                        shortTitle: "mock_short_title_\(index)"
                        )
                    )
                )
            
        } else if self.match == "mock_serial_number_404" {
            
        } else {
            for index in 1...20 {
                equipmentModel.append(
                    EquipmentModel(
                        id: "mock_id_\(index)",
                        serialNumber: "mock_serial_number_\(index)",
                        number: index,
                        equipmentTypeId: "mock_equipment_type_id_\(index)",
                        equipmentType: EquipmentTypeModel(
                            id: "mock_id_\(index)",
                            title: "mock_title_\(index)",
                            description: "mock_description_\(index)",
                            shortTitle: "mock_short_title_\(index)"
                        )
                    )
                )
            }
        }
        self.loading = false
    }
    #else
    func getEquipment() {
        // TODO: Some api stuff
    }
    #endif
}
