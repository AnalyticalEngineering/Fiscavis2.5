//
//  ReminderDetailView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/22/23.
//

import SwiftUI

struct ReminderDetailView: View {
    //MARK:  PROPERTIES
    @Binding var reminder: Reminder
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    @Environment(\.dismiss) private var dismiss
    //is form valid
    private var isFormValid: Bool {
        !editConfig.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.note ?? "")
                    }
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                        }
                        if editConfig.hasTime {
                            DatePicker("Select Date", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        Section {
                            NavigationLink {
                                SelectListView(selectedList: $reminder.list)
                            } label: {
                                HStack {
                                    Text("List")
                                    Spacer()
                                    Text(reminder.list!.name)
                                }
                            }
                        }
                    }.onChange(of: editConfig.hasDate) { hasDate in
                        if hasDate {
                            editConfig.reminderDate = Date()
                        }
                    }.onChange(of: editConfig.hasTime) { hasTime in
                        if hasTime {
                            editConfig.reminderTime = Date()
                        }
                    }
                }.listStyle(.insetGrouped)
            }.onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Budget Details")
                        
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                            do {
                              let updated = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                                if updated {
                                    //verify need for notification trigger
                                    if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                        let userData = UserData(title: reminder.title, body: reminder.note, date: reminder.reminderDate, time: reminder.reminderTime)
                                        //MARK:  SCHEDULE NOTIFICATION
                                        NotificationManager.scheduleNotification(userData: userData)
                                    }
                                }
                            } catch {
                                print(error)
                            }
                        dismiss()
                    }
                    .fontDesign(.serif)
                    .font(.title3)
                    .fontWeight(.bold)
                    .tint(.red)
                    .disabled(!isFormValid)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .fontDesign(.serif)
                    .font(.title3)
                    .fontWeight(.bold)
                    .tint(.red)
                }
            }
        }
    }
}


#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
