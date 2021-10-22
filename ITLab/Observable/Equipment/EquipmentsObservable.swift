//
//  EquipmentObservable.swift
//  ITLab
//
//  Created by Даниил on 11.07.2021.
//

import Foundation
import SwiftUI

final class EquipmentsObservable: ObservableObject {
    @Published var equipmentModel: [CompactEquipmentView] = []
    @Published var loading: Bool = true
    @Published var onlyFree: Bool = false
    @Published var match: String = ""
    
    func getEquipment() {
        self.loading = true
        defer {
            self.loading = false
        }
        EquipmentAPI.apiEquipmentGet(match: self.match, all: !self.onlyFree) { (equipmentModel, error) in
            if let error = error {
                print(error)
                return
            }
            self.equipmentModel = equipmentModel ?? [];
        }
    }
    
}

