//
//  EquipmentList.swift
//  ITLab
//
//  Created by Даниил on 10.07.2021.
//

import SwiftUI

struct EquipmentList: View {
    @State private var showOptions = true
    @EnvironmentObject private var equipmentObject: EquipmentsObservable
    
    var body: some View {
        VStack {
            if showOptions {
                EquipmentSearchBar(text: $equipmentObject.match, placehodler: "Поиск оборудования")
            }
            HStack {
                if showOptions {
                    Toggle(
                        isOn: $equipmentObject.onlyFree,
                        label: {
                            Text("Только свободное")
                                .font(.system(size: 12, weight: .light, design: .default))
                        }
                    )
                    .toggleStyle(
                        CheckBoxStyle()
                    )
                }
                
                Spacer()
                
                Button(
                    action: {
                        self.showOptions.toggle()
                    },
                    label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                )
            }
            List {
                if equipmentObject.loading {
                    GeometryReader {
                        geometry in
                        ProgressView()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height,
                                   alignment: .center)
                    }
                } else {
                    HStack {
                        Text("Тип")
                            .padding(.horizontal)
                            .frame(width: 200.0, height: 20.0, alignment: .center)
                        Spacer()
                        Text("Номер")
                            .padding(.horizontal)
                            .frame(width: 100.0, height: 20.0, alignment: .center)
                        Spacer()
                        Spacer()
                            .frame(width: 10, height: 10, alignment: .center)
                    }
                    ForEach(
                        self.equipmentObject.equipmentModel.filter {
                        equipment in
                        return (
                            self.equipmentObject.onlyFree ?
                                equipment.ownerId == nil : true &&
                                self.equipmentObject.match.isEmpty ? true : "\(String(describing: equipment.serialNumber)) \(equipment.equipmentType?.title) \(equipment.equipmentType?.shortTitle ?? "" )".lowercased().contains(self.equipmentObject.match.lowercased())
                            )
                        },
                        id: \._id
                    ) {
                        equip in
                        EquipmentItem(equipment: equip)
                    }
                }
            }.listStyle(
                GroupedListStyle()
            ).onAppear {
                if equipmentObject.equipmentModel.isEmpty {
                    equipmentObject.getEquipment()
                }
            }
        }
        
    }
}

struct CheckBoxStyle: ToggleStyle {
    var width: CGFloat = 20
    var height: CGFloat = 20
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle" )
                .frame(width: width, height: height)
                .foregroundColor(configuration.isOn ? .green : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            
            configuration.label
        }
    }
}

struct EquipmentList_Previews: PreviewProvider {
    static var previews: some View {
        var equipmentObservable = EquipmentsObservable()
        let view = EquipmentList()
        equipmentObservable.equipmentModel = [
            CompactEquipmentView.init(
                _id: UUID.init(),
                serialNumber: "13123123",
                _description: "desc",
                number: 0,
                equipmentTypeId: UUID.init(),
                equipmentType: CompactEquipmentTypeView.init(
                    _id: UUID.init(),
                    title: "RTX Nvdia 4090",
                    shortTitle: "",
                    _description: "powerful GPU",
                    rootId: nil,
                    parentId: nil
                ),
                ownerId: nil,
                parentId: nil
            ),
            CompactEquipmentView.init(
                _id: UUID.init(),
                serialNumber: "13123123",
                _description: "desc",
                number: 0,
                equipmentTypeId: UUID.init(),
                equipmentType: CompactEquipmentTypeView.init(
                    _id: UUID.init(),
                    title: "Macbook air early 2019 long long long long long",
                    shortTitle: "",
                    _description: "powerful GPU",
                    rootId: nil,
                    parentId: nil
                ),
                ownerId: nil,
                parentId: nil
            )
        ]
        return view
            .environmentObject(equipmentObservable)
    }
}
