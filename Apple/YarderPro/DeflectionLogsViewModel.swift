//
//  DeflectionViewModel.swift
//  Forestry
//
//  Created by Drew Hengehold on 9/24/24.
//

import Foundation
import CoreData

/*
 DESCRIPTION:
 This file serves as the point of interraction for the DeflectionLogEntity, it also forms the array containing the DeflectionLogEntities, which helps to group these logs together for use. Containined within this class are the core functions for creating, deleting, and fetching logs.
 */

class DeflectionLogsViewModel: ObservableObject {
    @Published var deflectionLogs: [DeflectionLogEntity] = []
    private var viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchDeflectionLogs()
    }
    
    // Fetch all deflection logs
    func fetchDeflectionLogs(sortedBy key: String = "logDate", ascending: Bool = true) {
        let request: NSFetchRequest<DeflectionLogEntity> = DeflectionLogEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: key, ascending: ascending)]
        
        do {
            deflectionLogs = try viewContext.fetch(request)
        } catch {
            print("Failed to fetch deflection logs: \(error)")
        }
    }
    
    // Add a new deflection log
    func addDeflectionLog() {
        let log = DeflectionLogEntity(context: viewContext)
        log.logName = "New Log"           // Set default values directly
        log.logDescription = "..."
        log.logDate = Date()
        log.id = UUID()
        
        saveContext()
    }
    
    // Update properties of an existing deflection log, removed because files are updated within the application, thus we do not need and update DeflectionLog file.
//    func updateDeflectionLog(log: DeflectionLogEntity, name: String?, description: String?, date: Date?) {
//        log.logName = name ?? log.logName
//        log.logDescription = description ?? log.logDescription
//        log.logDate = date ?? log.logDate
//        
//        saveContext()
//    }
    
    // Delete a specific deflection log
    func deleteDeflectionLog(log: DeflectionLogEntity) {
        viewContext.delete(log)
        saveContext()
    }
    
    // Save changes in the context
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                fetchDeflectionLogs() // Refresh logs after saving
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
