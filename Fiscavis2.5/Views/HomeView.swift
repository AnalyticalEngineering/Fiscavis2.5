//
//  HomeView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/19/23.
//

import SwiftUI

struct HomeView: View {
    //MARK:  PROPERTIES
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .today))
    private var todayResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .scheduled))
    private var scheduledResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .all))
    private var allResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .completed))
    private var completedResults: FetchedResults<Reminder>
    
    
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var searching: Bool = false
    
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValues()
    
    //MARK:  VIEW
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView{
                    
                    //    MARK:  Due Today / Scheduled Links
                    HStack {
                        
                        NavigationLink {
                            ReminderListView(reminders: todayResults)
                        } label: {
                            ReminderStatsView(icon: "calendar", title: "Due", count: reminderStatsValues.todayCount)
                        }
                        NavigationLink {
                            ReminderListView(reminders: scheduledResults)
                        } label: {
                            ReminderStatsView(icon: "calendar.circle.fill", title: "Upcoming", count: reminderStatsValues.scheduledCount, iconColor: .red)
                        }
                    }.padding([.leading, .trailing], 2)
                    
                    //    MARK:  All / Completed Links
                    HStack {
                        NavigationLink {
                            
                            ReminderListView(reminders: allResults)
                            
                        } label: {
                            ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatsValues.allCount, iconColor: .secondary)
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: completedResults)
                        } label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValues.completedCount, iconColor: .primary)
                        }
                    }
                    .padding([.leading, .trailing], 2)
                   
                    Text("Budgets")
                        .font(.title3)
                        .bold()
                        .padding()
                    
                    //MARK:  BUDGET LIST VIEW
                    BudgetListView(myLists: myListResults)
                }
                    //MARK:  ADD NEW BUDGET BUTTON
                    Button {
                        HapticManager.notification(type: .success)
                        isPresented = true
                    } label: {
                        ZStack{
                            Circle()
                                .frame(maxWidth: 50, maxHeight: 50)
                            VStack {
                                Image(systemName: "plus")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewBudgetListView { name, icon, color in
                        do {
                            try ReminderService.saveMyList(name, icon: icon, color )
                        } catch {
                            print(error)
                        }
                    }
                }
            }.listStyle(.plain)
                .onChange(of: search, perform: { searchTerm in
                    searching = !searchTerm.isEmpty ? true: false
                    searchResults.nsPredicate = ReminderService.getRemindersBySearchTerm(search).predicate
                })
                .overlay(alignment: .center, content: {
                    ReminderListView(reminders: searchResults)
                        .opacity(searching ? 1.0: 0.0)
                })
                .onAppear {
                    reminderStatsValues = reminderStatsBuilder.build(myListResults: myListResults)
                }
                .padding()
                .navigationTitle("Budgets & Bills")
        }.searchable(text: $search)
        
    }
}
    
 struct HomeView_Previews: PreviewProvider {
     static var previews: some View {
         HomeView()
             .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
     }
 }
