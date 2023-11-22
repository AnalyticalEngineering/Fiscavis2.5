//
//  Fiscavis2_5App.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/19/23.
//

import SwiftUI

@main
struct Fiscavis2_5App: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, 
                              CoreDataProvider.shared.persistentContainer.viewContext)
           
        }
    }
}
