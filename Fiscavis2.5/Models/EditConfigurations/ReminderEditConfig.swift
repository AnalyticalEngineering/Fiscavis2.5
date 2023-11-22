//
//  ReminderEditConfig.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/22/23.
//

import Foundation

struct ReminderEditConfig {
    var title: String = ""
    var notes: String?
    var isCompleted: Bool = false
    var hasDate: Bool = false
    var hasTime: Bool = false
    var reminderDate: Date?
    var reminderTime: Date?
    
    init() { }
    
    init(reminder: Reminder) {
        title = reminder.title ?? ""
        notes = reminder.note
        isCompleted = reminder.isCompleted
        reminderDate = reminder.reminderDate
        reminderTime = reminder.reminderTime
        hasDate = reminder.reminderDate != nil
        hasTime = reminder.reminderTime != nil
    }
}
