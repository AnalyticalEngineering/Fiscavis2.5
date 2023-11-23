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
    
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var searching: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                ScrollView {
                    BudgetListView(myLists: myListResults)
                    
                    
                    //   Spacer()
                    Button {
                        HapticManager.notification(type: .success)
                        isPresented = true
                    } label: {
                        ZStack{
                            Circle()
                                .frame(maxWidth: 200, maxHeight: 50)
                            VStack {
                                Image(systemName: "plus")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .sheet(isPresented: $isPresented) {
                 NavigationView {
                     AddNewBudgetListView { name, selectedIcon, color in
                         do {
                             try ReminderService.saveMyList(name, selectedIcon, color)
                         } catch {
                             print(error)
                         }
                     }
                 }
             }
             .listStyle(.plain)
             .onChange(of: search, perform: { searchTerm in
                 searching = !searchTerm.isEmpty ? true: false
                 searchResults.nsPredicate = ReminderService.getRemindersBySearchTerm(search).predicate
             })
             .overlay(alignment: .center, content: {
                 ReminderListView(reminders: searchResults)
                     .opacity(searching ? 1.0: 0.0)
             })
             .padding()
             .navigationTitle("Budgets")
         }.searchable(text: $search)
        
     }
 }

 struct HomeView_Previews: PreviewProvider {
     static var previews: some View {
         HomeView()
             .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
     }
 }
