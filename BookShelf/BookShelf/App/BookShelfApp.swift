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
    @State private var showingSplash = true
    
    var body: some Scene {
        WindowGroup {
            if showingSplash {
                LaunchScreenView(isActive: $showingSplash)
            } else {
                ScanView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
