//
//  EquipmentItem.swift
//  ITLab
//
//  Created by Даниил on 11.07.2021.
//

import SwiftUI

struct EquipmentItem: View {
    @State private var showFull = false
    var equipment: CompactEquipmentView
    @ObservedObject private var userObserved = UserObservable()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(equipment.equipmentType?.title ?? "")
                    .padding(.horizontal)
                    .frame(width: 200, height: 20, alignment: .center)
                Spacer()
                Text("\(equipment.number ?? 0)")
                    .padding(.horizontal)
                    .frame(width: 100, height: 20, alignment: .center)
                Spacer()
                Button(
                    action: {
                        self.loadData()
                        self.showFull.toggle()
                    },
                    label: {
                        Image(systemName: "info.circle")
                            .frame(width: 10, height: 10, alignment: .center)
                    }
                )
            }
            if showFull {
                ShowFullEquipmentInfo(fullMode: true,equipment: equipment)
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

private struct EquipmentInfoTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .padding(.vertical)
            .frame(alignment: .center)
    }
}

struct ShowFullEquipmentInfo: View {
    @EnvironmentObject var userObserved: UserObservable
    var fullMode: Bool = false
    var equipment: CompactEquipmentView
    var body: some View {
        VStack(alignment: .leading) {
            if fullMode {
                HStack {
                    Text("Тип:")
                        .padding(.horizontal)
                        .frame(width: 180.0, height: 20.0, alignment: .center)
                    Spacer()
                    Text("\(equipment.equipmentType?.title ?? "")")
                        .modifier(EquipmentInfoTextModifier())
                    Spacer()
                }
                HStack {
                    Text("Номер:")
                        .padding(.horizontal)
                        .frame(width: 180.0, height: 20.0, alignment: .center)
                    Spacer()
                    Text("\(equipment.number ?? 0)")
                        .modifier(EquipmentInfoTextModifier())
                    Spacer()
                }
            }
            HStack {
                Text("Владелец:")
                    .padding(.horizontal)
                    .frame(width: 180.0, height: 20.0, alignment: .center)
                Spacer()
                Text("\(self.userObserved.getFullNameWithEmail() ?? "Лаборатория")")
                    .modifier(EquipmentInfoTextModifier())
                Spacer()
            }
            HStack {
                Text("Серийный номер: ")
                    .padding(.horizontal)
                    .frame(width: 180.0, height: 20.0, alignment: .center)
                Spacer()
                Text("\(self.equipment.serialNumber ?? "")")
                    .modifier(EquipmentInfoTextModifier())
                Spacer()
            }
        }
    }
}

struct EquipmentItem_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentItem(
            equipment: CompactEquipmentView.init(
                _id: UUID.init(),
                serialNumber: "mock_serial_number",
                _description: "mock_desc",
                number: 0,
                equipmentTypeId: UUID.init(),
                equipmentType: CompactEquipmentTypeView.init(
                    _id: UUID.init(),
                    title: "mock_tittle",
                    shortTitle: "short_tittle",
                    _description: "short_desc",
                    rootId: UUID.init(),
                    parentId: UUID.init()
                ),
                ownerId: UUID.init(),
                parentId: UUID.init()
            )
        )
    }
}

struct EquipmentShowFull_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserObservable()
        user.user = UserView(
            _id: UUID(),
            firstName: "Даниил",
            lastName: "Демин",
            middleName: nil,
            phoneNumber: nil,
            email: "name.lastname@example.com",
            properties: nil
        )
        return ShowFullEquipmentInfo(
            equipment: CompactEquipmentView.init(
                _id: UUID.init(),
                serialNumber: "mock_serial_number",
                _description: "mock_desc",
                number: 0,
                equipmentTypeId: UUID.init(),
                equipmentType: CompactEquipmentTypeView.init(
                    _id: UUID.init(),
                    title: "mock_tittle",
                    shortTitle: "short_tittle",
                    _description: "short_desc",
                    rootId: UUID.init(),
                    parentId: UUID.init()
                ),
                ownerId: UUID.init(),
                parentId: UUID.init()
            )
        ).environmentObject(user)
    }
}

struct EquipmentShowFullFullmode_Previews: PreviewProvider {
    static var previews: some View {
        ShowFullEquipmentInfo(
            fullMode: true,
            equipment: CompactEquipmentView.init(
                _id: UUID.init(),
                serialNumber: "mock_serial_number",
                _description: "mock_desc",
                number: 0,
                equipmentTypeId: UUID.init(),
                equipmentType: CompactEquipmentTypeView.init(
                    _id: UUID.init(),
                    title: "mock_tittle",
                    shortTitle: "short_tittle",
                    _description: "short_desc",
                    rootId: UUID.init(),
                    parentId: UUID.init()
                ),
                ownerId: UUID.init(),
                parentId: UUID.init()
            )
        ).environmentObject(UserObservable())
    }
}
