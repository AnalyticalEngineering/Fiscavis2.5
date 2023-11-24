//
//  ReminderListView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/21/23.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    //reminder checked chaged function
    private func reminderCheckedChanged(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    // is selcted function
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    //delete reminder
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder)
            } catch {
                print(error)
            }
        }
    }
    
    var body: some View {
        
        VStack{
            List {
                ForEach(reminders) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                        switch event {
                        case .onSelect(let reminder):
                            selectedReminder = reminder
                        case .onCheckedChange(let reminder, let isCompleted):
                            reminderCheckedChanged(reminder: reminder, isCompleted: isCompleted)
                        case .onInfo:
                            showReminderDetail = true
                        }
                    }
                }.onDelete(perform: deleteReminder)
            }
            }
        .sheet(isPresented: $showReminderDetail) {
                ReminderDetailView(reminder: Binding($selectedReminder)!)
            }
        }
    }

struct ReminderListView_Previews: PreviewProvider{
    
    
    struct ReminderListContainer: View {
        @FetchRequest(sortDescriptors: [])
        private var reminderResults: FetchedResults<Reminder>
        
        var body: some View {
            ReminderListView(reminders: reminderResults)
        }
    }
    static var previews: some View{
        ReminderListContainer()
            .environment(\.managedObjectContext,
                          CoreDataProvider.shared.persistentContainer.viewContext)
    }
}

