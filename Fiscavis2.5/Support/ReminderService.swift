//
//  ReminderService.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/21/23.
//

import Foundation
import CoreData
import UIKit //UI Color

class ReminderService {
    //MARK: SAVING LIST FUNCTION AND SERVICE 
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }
    
    static func saveMyList(_ name: String, _ icon: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.icon = icon
        myList.color = color
        try save()
    }
    
}

