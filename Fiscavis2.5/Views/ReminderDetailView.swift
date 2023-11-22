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
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Note", text: $editConfig.notes ?? "")
                    }
                    Section{
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundStyle(.red)
                        }
                        if editConfig.hasDate{
                        DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        Toggle( isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundStyle(.blue)
                        }
                        if editConfig.hasTime {
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
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

                    }
                }.listStyle(.insetGrouped)
            }.onAppear{
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
