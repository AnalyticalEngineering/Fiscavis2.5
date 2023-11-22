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
            
            // Display List of Bills
            ReminderListView(reminders: reminderResults)
            
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Bill") {
                    openAddReminder = true
                }
            }.foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }.alert("Enter New Bill", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) {
                
            }
            //save the bill reminder
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

