//
//  DeflectionViewModel.swift
//  Forestry
//
//  Created by Drew Hengehold on 9/24/24.
//

import Foundation
import CoreData

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
        let newLog = DeflectionLogEntity(context: viewContext)
        newLog.logName = "New Log"           // Set default values directly
        newLog.logDescription = "..."
        newLog.logDate = Date()
        
        saveContext()
    }
    
    // Update properties of an existing deflection log
    func updateDeflectionLog(log: DeflectionLogEntity, name: String?, description: String?, date: Date?) {
        log.logName = name ?? log.logName
        log.logDescription = description ?? log.logDescription
        log.logDate = date ?? log.logDate
        
        saveContext()
    }
    
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
