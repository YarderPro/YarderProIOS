//
//  DeflectionDetails.swift
//  Forestry
//
//  Created by Drew Hengehold on 9/24/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Deflections"
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var deflectionLog: DeflectionLogEntity
    
    var body: some View {
        VStack {
            Picker("Select a Tab", selection: $selectedTab) {
                Text("Details").tag("Details")
                Text("Deflections").tag("Deflections")
                Text("Tension").tag("Tension")
                Text("Diagram").tag("Diagram")
            }
           .pickerStyle(.segmented)
            
            TabContent(selectedTab: selectedTab, deflectionLog: deflectionLog)
        }
    }
}

    
struct TensionView: View{
    var body: some View{
        Text("Math")
    }
}
    
struct DiagramView: View{
    var body: some View{
        Text("Drew")
    }
}
    
@ViewBuilder
func TabContent(selectedTab: String, deflectionLog: DeflectionLogEntity) -> some View {
    switch selectedTab {
    case "Details":
        DeflectionDetails(deflectionLog: deflectionLog)
    case "Deflections":
        DeflectionView(deflectionLog: deflectionLog)
    case "Tension":
        TensionView() // Replace with your actual view
    case "Diagram":
        DiagramView() // Replace with your actual view
    default:
        Text("Select a tab")
    }
    Spacer()
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        // Use the preview PersistenceController context for testing
        let context = PersistenceController.preview.persistenceContainer.viewContext
        
        // Create a sample DeflectionLogEntity for preview purposes
        let sampleLog = DeflectionLogEntity(context: context)
        sampleLog.logName = "Sample Log"
        sampleLog.logDescription = "This is a sample log description."
        sampleLog.logDate = Date()
        
        return NavigationView {
            ContentView(deflectionLog: sampleLog)
                .environment(\.managedObjectContext, context)
        }
    }
}
