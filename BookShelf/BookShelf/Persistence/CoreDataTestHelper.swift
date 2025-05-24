//
//  CoreDataTestHelper.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import CoreData
import Foundation

enum CoreDataTestHelper {
    
    static func makeInMemoryContext() -> NSManagedObjectContext {
        let controller = PersistenceController(inMemory: true)
        return controller.container.viewContext
    }
}
