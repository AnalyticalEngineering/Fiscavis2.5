//
//  BudgetListView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/21/23.
//

import SwiftUI

struct BudgetListView: View {
    //MARK:  PROPERTIES
    let myLists:  FetchedResults<MyList>
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            
            if myLists.isEmpty {
                ContentUnavailableView{
                    Label("No Budgets created.\nPress + Button and make a plan.", systemImage: "tray.fill")
                        .foregroundStyle(.primary)
                        .font(.title3)
                        .fontWeight(.bold)
                }
            } else {
                ForEach(myLists) { myList in
                    NavigationLink(value: myList){
                        VStack {
                            BudgetCard(myList: myList)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading], 5)
                                .font(.title3)
                                Divider()
                        }
                    }
                    .listRowBackground(colorScheme == .dark ? Color.colorGrey: Color.offWhite)
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: MyList.self) { myList in
                    BudgetListDetailView(myList: myList)
                        .navigationTitle(myList.name)
                }
            }
        }
    }
}
//#Preview {
//    BudgetListView()
//}
