//
//  EquipmentAdd.swift
//  ITLab
//
//  Created by Даниил on 15.07.2021.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}

struct EquipmentAddPage: View {
    @Environment(\.presentationMode) var presentationMode
    /// TODO: Сначала по api получить все типы
    /// затем надо выбрать из полученных если выбрал потвердить то что был добавлен
    /// если такого типа нет добавить свой
    /// и затем уже потвердить добавленное устройство
    @ObservedObject var equipmentObserved = EquipmentCreateObservable()
    @ObservedObject var equipmenstTypeObserver = EquipmentsTypeObservable()
    @ObservedObject var equipmentTypeObserver = EquipmentTypeCreateObservable()
    @State var serialNumber: String
    @State var showValidAlert: Bool = false
    @State private var alertMessage: AlertMessage = .empty
    @State var validError: EquipmentTypeAdder.ValidError = EquipmentTypeAdder.ValidError.titleEmpty
    @State var equipmentTypeID: UUID? = nil
    
    init(serialNumber: String) {
        self._serialNumber = State(initialValue: serialNumber)
    }
    
    enum AlertMessage: String {
        case titleEmpty = "Название не может быть пустым"
        case serialNumberEmpty = "Серийный номер не может быть пустым"
        case empty = ""
    }
    
    var body: some View {
        VStack {
            HStack {
                EquipmentTypePicker(validError: self.$validError, equipmentTypeID: self.$equipmentTypeID)
                    .environmentObject(self.equipmenstTypeObserver)
            }
            HStack {
                Text("Cерийный номер:")
                TextField("Серийный номер", text: $serialNumber)
                    .frame(width: 100, height: 20, alignment: .center)
            }.frame(alignment: .center)
            VStack {
                Button(
                    action: {
                        if serialNumber.isEmpty {
                            alertMessage = .serialNumberEmpty
                            showValidAlert = true
                            return
                        } else if self.validError == EquipmentTypeAdder.ValidError.titleEmpty {
                            alertMessage = .titleEmpty
                            showValidAlert = true
                            return
                        }
                        if let equipmentTypeId = equipmentTypeID {
                            self.equipmentObserved.equipmentTypeId = equipmentTypeId
                        } else if let equipmentTypeId = self.equipmentTypeObserver.createEquipmentType()?._id {
                            self.equipmentObserved.equipmentTypeId = equipmentTypeId
                        } else {
                            print("failed to created equipment type")
                        }
                        
                        equipmentObserved.serialNumber = serialNumber
                        if let code = equipmentObserved.createEquipment() {
                            switch code {
                            case .created:
                                self.presentationMode.wrappedValue.dismiss()
                            case .equipmentTypeNotFound:
                                print("equipment type not found")
                            case .serialNumberExist:
                                print("serial number exit")
                            default:
                                print("code \(code)")
                            }
                        }
                    },
                    label: {
                        Text("Добавить оборудование")
                    }
                ).alert(isPresented: $showValidAlert, content: {
                    Alert(
                        title: Text(alertMessage.rawValue),
                        dismissButton: .default(Text("Got it!"))
                    )
                })
            }
        }.onAppear {
            self.loadData()
        }
    }
    
    func loadData() {
        equipmenstTypeObserver.getEquipmentType()
    }
}

struct EquipmentTypePicker: View {
    @EnvironmentObject var equipmentsType: EquipmentsTypeObservable
    @State var isAddingType: Bool = true
    @State var selectedTypeIndex: Int = -1
    @Binding var validError: EquipmentTypeAdder.ValidError
    @Binding var equipmentTypeID: UUID?
    
    @State var title: String = ""
    @State var shortTitle: String = ""
    @State var description: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Выберите тип")
                Picker(
                    selection: $selectedTypeIndex.onChange(onIndexChange),
                    label: Text("\((selectedTypeIndex == -1 ? "Добавить тип" : equipmentsType.equipmentsType[selectedTypeIndex].title!))"),
                    content: {
                        ForEach(equipmentsType.equipmentsType.indices, id: \.self) {
                            (index: Int) in
                            if let title = equipmentsType.equipmentsType[index].title {
                                Text(title)
                            }
                        }
                        Text("Добавить тип").tag(-1)
                    }
                ).pickerStyle(MenuPickerStyle())
            }
            if isAddingType || selectedTypeIndex == -1 {
                EquipmentTypeAdder(title: $title, shortTitle: $shortTitle, description: $description, validError: $validError)
            }
        }
    }

    
    func loadData() {
        self.equipmentsType.getEquipmentType()
    }
    
    private func onIndexChange(index: Int) {
        if index == -1 {
            isAddingType = true
        } else {
            isAddingType = false
            equipmentTypeID = equipmentsType.equipmentsType[index]._id
        }
    }
}

struct EquipmentTypeAdder: View {
    @Binding var title: String
    @Binding var shortTitle: String
    @Binding var description: String
    @Binding var validError: ValidError
    
    enum ValidError: String {
        case titleEmpty = "titleEmpty"
        case no = ""
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Полное название")
                Spacer()
                TextField("Введите название", text: self.$title).onChange(of: title, perform: { value in
                    if value.isEmpty {
                        self.validError = ValidError.titleEmpty
                    } else {
                        self.validError = ValidError.no
                    }
                })
                Spacer()
            }
            HStack {
                Spacer()
                Text("Короткое название")
                Spacer()
                TextField("Введите короткое название", text: self.$shortTitle)
                Spacer()
            }
            HStack {
                Spacer()
                Text("Описание")
                Spacer()
                TextField("Введите описание", text: self.$description)
                Spacer()
            }
        }.onAppear {
            if title.isEmpty {
                self.validError = ValidError.titleEmpty
            } else {
                self.validError = ValidError.no
            }
        }.onDisappear {
            self.validError = ValidError.no
        }
    }
    
    func getTitle() -> String {
        return self.title
    }
}

struct EquipmentAdd_Previews: PreviewProvider {
    static var previews: some View {
        let view = EquipmentAddPage(serialNumber: "example")
        view.loadData()
        return view
    }
}
