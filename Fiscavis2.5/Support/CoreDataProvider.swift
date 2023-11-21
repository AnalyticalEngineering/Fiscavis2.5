//
//  CoreDataProvider.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/19/23.
//

import Foundation
import CoreData

class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "FiscavisModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Error initializing Budget Model \(error)")
            }
        }
        
    }
    
}

