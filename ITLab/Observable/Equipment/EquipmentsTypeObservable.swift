//
//  EquipmentsTypeObservable.swift
//  ITLab
//
//  Created by Даниил on 15.07.2021.
//

import Foundation

class EquipmentsTypeObservable: ObservableObject {
    @Published var equipmentsType: [CompactEquipmentTypeView] = []
    @Published var isLoading: Bool = true
    func getEquipmentType() {
        self.isLoading = true
        defer {
            self.isLoading = false
        }
        EquipmentTypeAPI.apiEquipmentTypeGet { (equipmentsType, error) in
            if let error = error {
                print(error)
                return
            }
            self.equipmentsType = equipmentsType ?? []
        }
    }
}
