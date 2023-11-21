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
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {

                BudgetListView(myLists: myListResults)
                   
                }
          
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
            
            
            .sheet(isPresented: $isPresented) {
                NavigationView{
                    AddNewBudgetListView { name, selectedIcon, color in
                        do {
                            try ReminderService.saveMyList(name, selectedIcon, color)
                        }catch {
                            print(error)
                        }
                    }   // save the list to the database
                }
            }
            .padding(.horizontal)
        
      

    }
}


#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
