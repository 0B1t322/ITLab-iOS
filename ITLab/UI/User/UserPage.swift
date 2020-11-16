//
//  UserPage.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 10/28/20.
//

import SwiftUI

struct UserPage: View {
    @State var user: UserView
    
    @State var equipments: [EquipmentView] = []
    @State var isLoadingEquipments: Bool = true
    
    
    var body: some View {
        List {
            Section(header: VStack(alignment: .leading) {
                if let lastName = user.lastName {
                    Text(lastName)
                        .foregroundColor(Color("user.title"))
                        .fontWeight(.bold)
                        .font(.title)
                        .textCase(.none)
                }
                
                if let firstName = user.firstName {
                    Text(firstName)
                        .foregroundColor(Color("user.title"))
                        .fontWeight(.bold)
                        .font(.title)
                        .textCase(.none)
                }
                
                if let middleName = user.middleName {
                    Text(middleName)
                        .foregroundColor(Color("user.title"))
                        .fontWeight(.bold)
                        .font(.title)
                        .textCase(.none)
                }
            }) {
                if let email = user.email {
                    HStack(alignment: .center) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                        
                        Button(action: {
                            UIApplication.shared.open(URL(string: "mailto://compose?to=\(email)")!)
                        }) {
                            Text(email)
                        }
                        .contextMenu() {
                            Button(action: {
                                    UIApplication.shared.open(URL(string: "mailto://compose?to=\(email)")!)
                            }) {
                                Text("Отправить письмо")
                                Image(systemName: "square.and.pencil")
                            }
                            
                            Button(action: {
                                UIPasteboard.general.string = email
                            }) {
                                Text("Копировать")
                                Image(systemName: "doc.on.doc")
                            }
                        }
                    }
                }
                
                if let phone = user.phoneNumber {
                    HStack(alignment: .center) {
                        Image(systemName: "phone.circle.fill")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                        
                        Button(action: {
                            let regex = try! NSRegularExpression(pattern: "[^0-9]")
                            let phoneRex = regex.stringByReplacingMatches(in: phone, options: [], range: NSRange(0..<phone.utf8.count), withTemplate: "")
                            
                            UIApplication.shared.open(URL(string: "tel://\(phoneRex)")!)
                        }) {
                            Text(phone)
                        }
                        .contextMenu() {
                            Button(action: {
                                
                                let regex = try! NSRegularExpression(pattern: "[^0-9]")
                                let phoneRex = regex.stringByReplacingMatches(in: phone, options: [], range: NSRange(0..<phone.utf8.count), withTemplate: "")
                                
                                UIApplication.shared.open(URL(string: "tel://\(phoneRex)")!)
                            }) {
                                Text("Набрать номер")
                                Image(systemName: "phone")
                            }
                            
                            Button(action: {
                                UIPasteboard.general.string = phone
                            }) {
                                Text("Копировать")
                                Image(systemName: "doc.on.doc")
                            }
                        }
                    }
                }
                
                if let vkId = user.properties?.first(where: { (property) -> Bool in
                    return property.userPropertyType?.title == "VKID"
                })?.value {
                    HStack(alignment: .center) {
                        Image(systemName: "questionmark.square.fill")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                        
                        Button(action: {
                            UIApplication.shared.open(URL(string: "vk://vk.com/id\(vkId)")!)
                        }) {
                            Text("@\(vkId)")
                        }
                        .contextMenu() {
                            Button(action: {
                                UIApplication.shared.open(URL(string: "vk://vk.com/id\(vkId)")!)
                            }) {
                                Text("Открыть VK")
                                Image(systemName: "questionmark.square.fill")
                            }
                            
                            Button(action: {
                                UIPasteboard.general.string = vkId
                            }) {
                                Text("Копировать")
                                Image(systemName: "doc.on.doc")
                            }
                        }
                    }
                }
                
                if let group = user.properties?.first(where: { (property) -> Bool in
                    return property.userPropertyType?.title == "Учебная группа"
                })?.value {
                    HStack(alignment: .center) {
                        Image(systemName: "graduationcap.fill")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                        Text(group)
                    }
                }
            }
            
            Section(header: Text("Техника на руках")) {
                if isLoadingEquipments {
                    GeometryReader() { g in
                        ProgressView()
                            .frame(width: g.size.width, height: g.size.height, alignment: .center)
                        
                    }
                } else {
                    if equipments.count > 0 {
                        VStack (alignment: .leading) {
                            ForEach(equipments, id: \._id) {
                                equipment in
                                
                                EquipmentStack(equipment: equipment)
                            }
                        }
                    } else {
                        Text("Оборудование на руках нет")
                    }
                }
            }
            .onAppear() {
                getEquimpment()
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func getEquimpment() {
        AppAuthInteraction.shared.performAction { (token, _) in
            
            EquipmentUserAPI.apiEquipmentUserUserIdGet(userId: user._id!) { (equipments, error) in
                
                if let error = error {
                    print(error)
                    self.isLoadingEquipments = false
                    return
                }
                
                self.equipments = equipments ?? []
                self.isLoadingEquipments = false
            }
            
        }
    }
}

extension UserPage {
    struct EquipmentStack : View {
        @State var equipment: EquipmentView
        var body: some View {
            VStack(alignment: .leading) {
                Text(equipment.equipmentType!.title!)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.bottom, 2)
                
                HStack(alignment: .center) {
                    Text("S/N:")
                    Text(equipment.serialNumber!)
                }
            } .padding(5)
        }
    }
}

struct UserPage_Previews: PreviewProvider {
    static var previews: some View {
        UserPage(user: UserView(_id: nil, firstName: nil, lastName: nil, middleName: nil, phoneNumber: nil, email: nil, properties: nil))
    }
}
