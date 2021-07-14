//
//  EquipmentItem.swift
//  ITLab
//
//  Created by Даниил on 11.07.2021.
//

import SwiftUI

struct EquipmentItem: View {
    @State private var showFull = false
    var equipment: EquipmentModel
    @ObservedObject private var userObserved = UserObservable()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(equipment.equipmentType.title)
                Spacer(minLength: 20)
                Text("\(equipment.number)")
                Spacer()
                Button(
                    action: {
                        self.loadData()
                        self.showFull.toggle()
                    },
                    label: {
                        Image(systemName: "info.circle")
                    }
                )
            }
            if showFull {
                ShowFullEquipmentInfo(equipment: equipment)
                    .environmentObject(userObserved)
            }
        }
    }
    
    func loadData() {
        if let ownerId = self.equipment.ownerId {
            self.userObserved.getUser(userId: ownerId)
        }
    }
}

private struct ShowFullEquipmentInfo: View {
    @EnvironmentObject var userObserved: UserObservable
    var equipment: EquipmentModel
    var body: some View {
        VStack(alignment: .leading) {
                HStack {
                    Text("Владелец:")
                        .padding(.horizontal)
                    Spacer()
                    Text("\(self.userObserved.getFullName() ?? "Лаборатория")")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding(.vertical)
                    Spacer()
                }
                HStack {
                    Text("Серийный номер: ")
                        .padding(.leading)
                    Spacer()
                    Text("\(self.equipment.serialNumber)")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding(.vertical)
                    Spacer()
                }
            }
    }
}

struct EquipmentItem_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentItem(
            equipment: EquipmentModel(id: "some_id", serialNumber: "some_serial_number", number: 0, equipmentTypeId: "some_elementtypeid", equipmentType: EquipmentTypeModel(id: "some_id", title: "some_title", description: "some_description", shortTitle: "some_short_title"))
        )
    }
}

struct EquipmentShowFull_Previews: PreviewProvider {
    static var previews: some View {
        ShowFullEquipmentInfo(equipment: EquipmentModel(id: "some_id", serialNumber: "some_serial_number", number: 0, equipmentTypeId: "some_elementtypeid", equipmentType: EquipmentTypeModel(id: "some_id", title: "some_title", description: "some_description", shortTitle: "some_short_title"))).environmentObject(UserObservable())
    }
}
