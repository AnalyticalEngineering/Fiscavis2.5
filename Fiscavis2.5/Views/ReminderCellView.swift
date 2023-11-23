//
//  ReminderCellView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/21/23.
//

import SwiftUI



//MARK:  REMINDER EVENT ENUM
enum ReminderCellEvent {
    case onInfo
    case onCheckedChange(Reminder, Bool)
    case onSelect(Reminder)
}




struct ReminderCellView: View {
    //MARK:  PROPERTIES
    let reminder: Reminder
    let delay = Delay()
    let isSelected: Bool
    
    @State private var checked: Bool = false
    
    let onEvent: (ReminderCellEvent) -> Void
    
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
                    HapticManager.notification(type: .success)
                    checked.toggle()  //task complete
                 
                    delay.cancel()   //cancel old task
                    
                    delay.performWork {
                        onEvent(.onCheckedChange(reminder, checked))  //call onCheckedChange inside delay time
                    }
                 
                }
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                if let note = reminder.note, !note.isEmpty {
                    Text(note)
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
            Spacer()
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1.0 : 0.0)
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect(reminder))
        }
    }
}

struct ReminderCellView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderCellView(reminder: PreviewData.reminder, isSelected: false, onEvent: { _ in } )
    }
}
