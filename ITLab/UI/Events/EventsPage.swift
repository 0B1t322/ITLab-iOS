//
//  EventsPage.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 06.10.2020.
//

import SwiftUI

struct EventsPage: View {
    
    @State var events : [CompactEventView] = []
    @State var isLoading: Bool = true;
    
    @State var isEditungRight = AuthorizeController.shared?.getUserInfo()?.getRole("CanEditEvent") ?? false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                } else {
                    ScrollView{
                        VStack {
                            ForEach(0..<events.count) { index in
                                EventStack(event: events[index])
                                
                                if index + 1 != events.count {
                                    Divider()
                                        .padding(.vertical, 5.0)
                                }
                                
                            }
                            .padding([.leading, .trailing], 10)
                        }
                        
                    }
                }
                
            }
            .navigationTitle("События")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(leading: Button(action: {
                isLoading = true
                getEvents()
                
            }) {
                Image(systemName: "arrow.clockwise").padding([.top, .bottom, .trailing], 15)
            }, trailing:
                VStack{
                    if self.isEditungRight{
                        Button(action: {
                            print("Not working")
                        }) {
                            Image(systemName: "plus")
                                .padding([.top, .leading, .bottom], 15)
                        }
                    }
                })
        }
        
        
        .onAppear{
            getEvents()
        }
    }
    
    
    
    func getEvents()
    {
        if self.events.isEmpty {
            self.isLoading = true
        }
        
        AuthorizeController.shared!.performAction { (token, _, _) in
            
            SwaggerClientAPI.customHeaders = ["Authorization" : "Bearer \(token ?? "")"]
            
            let date = Date()
            var dateComponents = DateComponents()
            
            dateComponents.year = Calendar.current.component(.year, from: date)
            dateComponents.month = Calendar.current.component(.month, from: date) - 1
            dateComponents.day = Calendar.current.component(.day, from: date)
            dateComponents.hour = Calendar.current.component(.hour, from: date)
            dateComponents.minute = Calendar.current.component(.minute, from: date)
            dateComponents.timeZone = Calendar.current.timeZone
            
            let newDate = Calendar.current.date(from: dateComponents)
            
            EventAPI.apiEventGet(begin: newDate) { (events, error) in
                
                self.events = events?.sorted() { (a, b) -> Bool in
                    a.beginTime! > b.beginTime!
                } ?? []
                self.isLoading = false
                
            }
        }
    }
}

extension EventsPage {
    private struct EventStack : View {
        
        @State var event : CompactEventView
        
        var body: some View {
            NavigationLink(destination: EventPage(compactEvent: event))
            {
                HStack {
                    VStack (alignment: .leading) {
                        Text(event.title ?? "Not title")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        Text(event.eventType?.title ?? "Not event type")
                            .fontWeight(.light)
                            .padding(.bottom, 5)
                        
                        ProgressView(value: Float(event.currentParticipantsCount ?? 4), total: Float(event.targetParticipantsCount ?? 10)).progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        
                        HStack{
                            HStack {
                                Image(systemName: "clock")
                                Text(dateFormate(event.beginTime ?? Date()))
                                    .fontWeight(.light)
                            }
                            
                            Spacer()
                            
                            HStack {
                                Text("Готовность \(event.currentParticipantsCount ?? 4)/\(event.targetParticipantsCount ?? 10)")
                                    .fontWeight(.light)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    
                    Image(systemName: "chevron.right")
                        .padding(.leading, 15.0)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .frame(height: 100)
                
            }
            .buttonStyle(PlainButtonStyle())
        }
        
        func dateFormate(_ date: Date) -> String
        {
            let dateFormmat = DateFormatter()
            
            dateFormmat.dateFormat = "dd.MM.yy HH:mm"
            return dateFormmat.string(from: date)
        }
    }
}

struct EventsPage_Previews: PreviewProvider {
    static var previews: some View {
        EventsPage()
    }
}
