//
//  YarderProApp.swift
//  YarderPro
//
//  Created by Drew Hengehold on 9/24/24.
//

/*
 As the @main, this swift file is used to initialize the persistence controller, which is injected into the DeflectionLogsView as context. This file is in some ways a formality which is only used when running the app in the simulator or when its downloaded. 
 */

import SwiftUI
import CoreData

@main
struct YarderProApp: App {
    // Initialize the Core Data stack and context
    @StateObject private var persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            //injecting view context and defining the enviornment using the initialized Persistence controller.
            DeflectionLogsView(context: PersistenceController.shared.persistenceContainer.viewContext)
                .environment(\.managedObjectContext, persistenceController.persistenceContainer.viewContext)
        }
    }
}
