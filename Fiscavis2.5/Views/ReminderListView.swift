//
//  ReminderListView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/21/23.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                    case .onSelect(let reminder):
                        print("onSelect")
                    case .onCheckingChange(let reminder):
                        print("onCheckedChange")
                    case .onInfo:
                        print("onInfo")
                }
            }
        }
    }
}
