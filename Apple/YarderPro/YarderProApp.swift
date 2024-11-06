//
//  YarderProApp.swift
//  YarderPro
//
//  Created by Drew Hengehold on 9/24/24.
//

import SwiftUI
import CoreData

@main
struct YarderProApp: App {
    // Initialize the Core Data stack and context
    @StateObject private var persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            DeflectionLogsView(context: PersistenceController.shared.persistenceContainer.viewContext)
                .environment(\.managedObjectContext, persistenceController.persistenceContainer.viewContext)
        }
    }
}
