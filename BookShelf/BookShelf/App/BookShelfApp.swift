//
//  BookShelfApp.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import SwiftUI

@main
struct BookShelfApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ScanView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
