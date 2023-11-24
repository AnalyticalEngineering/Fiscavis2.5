//
//  Fiscavis2_5App.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/19/23.
//

import SwiftUI
import UserNotifications

@main
struct Fiscavis2_5App: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                // notification is granted
            } else {
                // display message to the user
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, 
                              CoreDataProvider.shared.persistentContainer.viewContext)
           
        }
    }
}
