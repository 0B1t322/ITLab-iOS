//
//  UserPage.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 10/28/20.
//

import SwiftUI

struct UserPage: View {
    @State var user: UserView
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var equipments: [EquipmentView] = []
    @State var isLoading: Bool = true
    
    var body: some View {
        VStack (alignment: .leading) {
            Button (action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(Font.title2.weight(.medium))
                    
                    Text("Пользователи")
                        .font(.title3)
                }
            }) .padding([.top, .leading], 12.0)
            VStack (alignment: .leading) {
                Text("\(user.lastName ?? "") \(user.firstName ?? "") \(user.middleName ?? "")")
                    .font(.title)
                    .fontWeight(.bold)
                
                Divider()
                
                VStack(alignment: .leading) {
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            if user.email != nil {
                                Text("Email:")
                                    .font(.headline)
                            }
                            
                            if user.phoneNumber != nil {
                                Text("Телефон:")
                                    .font(.headline)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            if user.email != nil {
                                Button(action: {
                                    if let email = user.email {
                                        UIApplication.shared.open(URL(string: "mailto://compose?to=\(email)")!)
                                    }
                                }) {
                                    Text(user.email!)
                                }
                            }
                            
                            if user.phoneNumber != nil {
                                Button(action: {
                                    if var phone : String = user.phoneNumber {
                                        let regex = try! NSRegularExpression(pattern: "[^0-9]")
                                        phone = regex.stringByReplacingMatches(in: phone, options: [], range: NSRange(0..<phone.utf8.count), withTemplate: "")
                                        
                                        UIApplication.shared.open(URL(string: "tel://\(phone)")!)
                                    }
                                }) {
                                    Text(user.phoneNumber!)
                                }
                            }
                        }
                    }
                }
                
                Divider()
                
                if isLoading {
                    ProgressView()
                        .padding(.top, 15)
                        .padding(.horizontal, (UIScreen.main.bounds.width / 2) - 10)
                } else {
                    VStack (alignment: .leading) {
                        Text("Оборудование")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        
                        if equipments.count > 0 {
                            VStack (alignment: .leading) {
                                ForEach(equipments, id: \._id) {
                                    equipment in
                                    
                                    Text(equipment.equipmentType!.title!)
                                    Text(equipment.serialNumber!)
                                }
                            } .padding(.bottom, 10.0)
                        } else {
                            Text("Оборудование на руках нет")
                        }
                    }
                    
                    Divider()
                    
                    VStack (alignment: .leading) {
                        Text("Участие в событиях")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20.0)
            .padding(.top, 10)
        }        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        .navigationBarHidden(true)
        .onAppear() {
            getEquimpment()
        }
    }
    
    func getEquimpment() {
        AuthorizeController.shared!.performAction { (token, _, _) in
            
            SwaggerClientAPI.customHeaders = ["Authorization" : "Bearer \(token ?? "")"]
            EquipmentUserAPI.apiEquipmentUserUserIdGet(userId: user._id!) { (equipments, error) in
                
                if let error = error {
                    print(error)
                    self.isLoading = false
                    return
                }
                
                self.equipments = equipments ?? []
                self.isLoading = false
            }
            
        }
    }
}

struct UserPage_Previews: PreviewProvider {
    static var previews: some View {
        UserPage(user: UserView(_id: nil, firstName: nil, lastName: nil, middleName: nil, phoneNumber: nil, email: nil, properties: nil))
    }
}
