//
//  BudgetListDetailView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/21/23.
//

import SwiftUI

struct BudgetListDetailView: View {
    //MARK:  PROPERTIES
    @Environment(\.dismiss) private var dismiss
    
    let myList: MyList
    
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""
    
    @FetchRequest(sortDescriptors: [])
    
    private var reminderResults: FetchedResults<Reminder>
    
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    init(myList: MyList) {
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: myList))
    }
    var body: some View {
        VStack {
            
            //MARK:  REMINDER LIST VIEW
            ReminderListView(reminders: reminderResults)
            
            Button {
                HapticManager.notification(type: .success)
              openAddReminder = true
            } label: {
                ZStack{
                    Circle()
                        .frame(width: 50, height: 50)
                    VStack {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }.padding(.bottom)
        .alert("Enter New Bill", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) {
                
            }
            //MARK:  SAVE REMINDER BUTTON
            Button("Save") {
                if isFormValid{
                    HapticManager.notification(type: .success)
                        do {
                            try ReminderService.saveReminderToMyList(myList: myList, reminderTitle: title)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
struct BudgetListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetListDetailView(myList: PreviewData.myList)
    }
}

