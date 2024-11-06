//
//  AnchorSide.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/17/24.
//


import SwiftUI


struct AnchorSide: View {
    @ObservedObject var deflectionLog: DeflectionLogEntity
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct AnchorSide_Preview: PreviewProvider {
    static var previews: some View {
        // Use the preview PersistenceController context for testing
        let context = PersistenceController.preview.persistenceContainer.viewContext
        
        // Create a sample DeflectionLogEntity for preview purposes
        let sampleLog = DeflectionLogEntity(context: context)
        sampleLog.logName = "Sample Log"
        sampleLog.logDescription = "This is a sample log description."
        sampleLog.logDate = Date()
        
        return NavigationView {
            AnchorSide(deflectionLog: sampleLog)
                .environment(\.managedObjectContext, context)
        }
    }
}
