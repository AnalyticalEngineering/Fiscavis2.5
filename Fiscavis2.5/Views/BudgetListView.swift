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
   // let myList: MyList
    
    var body: some View {
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                ContentUnavailableView{
                    Label("No Budgets", systemImage: "tray.fill")
                        .foregroundStyle(.primary)
                        .font(.title2)
                        .fontWeight(.bold)
                }
            } else {
                ForEach(myLists) { myList in
                    VStack {
                   BudgetCard(myList: myList)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading], 10)
                            .font(.title3)
                        Divider()
                    }
                }
            }
            
        }
    }
}
//#Preview {
//    BudgetListView()
//}
