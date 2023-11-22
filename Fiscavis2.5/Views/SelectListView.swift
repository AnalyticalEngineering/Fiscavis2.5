//
//  SelectListView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/22/23.
//

import SwiftUI

struct SelectListView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListsFetchResults: FetchedResults<MyList>
    @Binding var selectedList: MyList?
    
    var body: some View {
        List(myListsFetchResults) { myList in
            HStack {
                HStack {
                    Image(systemName: myList.icon)
                        .foregroundColor(Color(myList.color))
                    Text(myList.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedList = myList
                }
                
                Spacer()
                
                if selectedList == myList {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct SelectListView_Previews: PreviewProvider {
    static var previews: some View {
        SelectListView(selectedList: .constant(PreviewData.myList))
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}
