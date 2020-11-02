//
//  UsersListPage.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 10/28/20.
//

import SwiftUI
import UIKit

extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Поиск пользователя"
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}


struct UsersListPage: View {
    @State var isLoading: Bool = true
    @State var users: [UserView] = []
    @State var userSearch: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                } else {
                    VStack {
                        SearchBar(text: $userSearch)
                            .padding(.horizontal, 10)
                    }
                    ScrollView{
                        VStack(alignment: .leading) {
                            ForEach(self.users.filter {
                                self.userSearch.isEmpty ? true : "\($0.lastName ?? "") \($0.firstName ?? "") \($0.middleName ?? "")".lowercased().contains(self.userSearch.lowercased())
                            }, id: \._id) { user in
                                
                                UserStack(user: user)
                                
                                Divider()
                                    .padding(.vertical, 10.0)
                                
                            }
                            .padding([.leading, .trailing], 10)
                        }
                    }
                }
            }
            .navigationTitle("Пользователи")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear() {
                getUsers()
                UIApplication.shared.addTapGestureRecognizer()
            }
        }
    }
    
    func getUsers() {
        AppAuthInteraction.shared.performAction { (token, _) in
            
            UserAPI.apiUserGet(count: -1) { (users, error) in
                if let error = error {
                    print(error)
                    self.isLoading = false
                    return
                }
                
                guard let users = users else {
                    print("Not data")
                    self.isLoading = false
                    return
                }
                DispatchQueue.main.async {
                    self.users =  users.filter {$0.lastName != nil}
                    self.users.sort { (a, b) -> Bool in
                        a.lastName ?? "" < b.lastName ?? ""
                    }
                    self.isLoading = false
                }
            }
        }
    }
}

extension UsersListPage {
    struct UserStack: View {
        @State var user: UserView
        
        var body: some View {
            NavigationLink(destination: UserPage(user: self.user)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(user.lastName ?? "") \(user.firstName ?? "") \(user.middleName ?? "")")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.bottom, 3.0)
                        
                        Text("Email: \(user.email ?? "")")
                        Text("Телефон: \(user.phoneNumber ?? "")")
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(.leading, 15.0)
                }
                .padding(.horizontal, 10.0)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct UsersListPage_Previews: PreviewProvider {
    static var previews: some View {
        UsersListPage()
    }
}
