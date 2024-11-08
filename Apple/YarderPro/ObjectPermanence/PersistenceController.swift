//
//  PersistenceController.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/18/24.
//

import CoreData

class PersistenceController: ObservableObject {
    static let shared = PersistenceController()
    
    // Preview configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.persistenceContainer.viewContext
        
        // Sample data setup for preview
        for i in 1...5 {
            let log = DeflectionLogEntity(context: viewContext)
            log.id = UUID()
            log.logName = "Test Log \(i)"
            log.logDescription = "Description for test log \(i)"
            log.logDate = Date()
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return controller
    }()
    
    // Core Data container configuration
    lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "YarderPro")
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return container
    }()
    
    private init(inMemory: Bool = false) {
        if inMemory {
            persistenceContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
    }
    
    // Save function for manually saving context changes
    func save() {
        let context = persistenceContainer.viewContext
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
}
