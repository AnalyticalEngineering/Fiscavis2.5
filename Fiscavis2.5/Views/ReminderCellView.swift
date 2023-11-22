//
//  ReminderCellView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/21/23.
//

import SwiftUI

struct ReminderCellView: View {
    //MARK:  PROPERTIES
    let reminder: Reminder
    @State private var checked: Bool = false
    
    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    var body: some View {
        HStack {
            
            Image(systemName: checked ? "circle.inset.filled": "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    checked.toggle()
                }
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                if let notes = reminder.note, !notes.isEmpty {
                    Text(notes)
                        .opacity(0.4)
                        .font(.caption)
                }
                
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formatDate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.4)
            }
            
        }
    }
}

struct ReminderCellView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderCellView(reminder: PreviewData.reminder)
    }
}