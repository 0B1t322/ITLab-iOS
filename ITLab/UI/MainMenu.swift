//
//  MainMenu.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 29.09.2020.
//

import SwiftUI
import PushNotification
import RealmSwift

struct MainMenu: View {
    
    var eventPage = EventsPage()
    var usersPage = UsersListPage()
    var projectsPage = ProjectsMenuPage()
    @State var user: UserRealm = UserRealm()
    
    var body: some View {
        TabView {
            eventPage
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                        Text("События")
                    }
                }
            
            projectsPage
                .tabItem {
                    VStack {
                        Image(systemName: "square.grid.2x2.fill")
                        Text("Проекты")
                    }
                }
            
            usersPage
                .tabItem {
                    VStack {
                        Image(systemName: "person.2.fill")
                        Text("Сотрудники")
                    }
                }
            
            ProfilePage(user: $user)
                .tabItem {
                    VStack {
                        Image(systemName: "person.crop.circle")
                        Text("Профиль")
                        
                    }
                }
        }
        .onAppear {
            OAuthITLab.shared.getToken { token in
                activateNotify(user: token)
                
                usersPage.loadingData {
                    do {
                        let realm = try Realm()
                        
                        if let profile = realm.objects(UserRealm.self).filter({
                            $0.id == OAuthITLab.shared.getUserInfo()?.userId
                        })
                            .first {
                            user = profile
                        }
                    } catch {
                        print("Not load user profile")
                    }
                }
                
                eventPage.loadingData()
                projectsPage.reportsObject.getReports()
            }
            
            Contact.requestAccess()
            ITLabCalendar.requestAccess()
        }
    }
    
    private func activateNotify(user jwt: String) {
        if let serverAPI = Bundle.main.object(forInfoDictionaryKey: "ServerApi") as? [String: String] {
            if let pushURL = serverAPI["PushNotification"],
               !pushURL.isEmpty,
               var url = URLComponents(string: pushURL) {
                url.scheme = "https"
                
                PushNotification.notificationActivate(url.string!,
                                                      authenticationMethod: .jwt(token: jwt))
            } else if let url = URL(string: SwaggerClientAPI.getURL()
                                                + "/api/push") {
                
                PushNotification.notificationActivate(url.string,
                                                      authenticationMethod: .jwt(token: jwt))
            }
        }
    }
}
