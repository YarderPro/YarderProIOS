//
//  ContentView.swift
//  Forestry
//
//  Created by Drew Hengehold on 9/24/24.
//


/*
 DESCRIPTION:
 One of the first files created, contentview sets up the tabs to ensure that users can switch between all necissary views, modifying the data in them using TextFields and then that data is modified in the core data. This file is essentially the scene that users use to modify the nested views.
 */

import SwiftUI

struct ContentView: View {
    //Change the default selected tab
    @State private var selectedTab = "Details"
    
    //Used to inject the viewContext and deflection log. These elements are passed to the tabs.
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var deflectionLog: DeflectionLogEntity
    
    var body: some View {
        //A V stack (Verticle Stack) is used to list objects ontop of one another
        VStack {
            // The picker is used to list out the tabs which can be selected. The picker is built into apple ui kit.
            Picker("Select a Tab", selection: $selectedTab) {
                Text("Details").tag("Details")
                Text("Deflections").tag("Deflections")
                Text("Tension").tag("Tension")
                Text("Diagram").tag("Diagram")
            }
           .pickerStyle(.segmented)
            
            // The picker requires this tab content, defined below, to list the content
            TabContent(selectedTab: selectedTab, deflectionLog: deflectionLog)
        }
    }
}
    
// Not yet implimented, this is more detailed in future opportunities and elements of it are clarified in the unused ModelCanvas.swift file
struct DiagramView: View{
    var body: some View{
        Text("Coming Soon")
            .font(.title)
    }
}
    
//To switch between views, the tab content function is used. It switches between Details, Deflections, Tension, and Diagram. The views are then passed the Deflection Log being used so they can modify it.
@ViewBuilder
func TabContent(selectedTab: String, deflectionLog: DeflectionLogEntity) -> some View {
    switch selectedTab {
    case "Details":
        DeflectionDetails(deflectionLog: deflectionLog) //Defined in DeflectionDetails.swift
    case "Deflections":
        DeflectionView(deflectionLog: deflectionLog) //Defined in DeflectionView.swift
    case "Tension":
        Tension(deflectionLog: deflectionLog) //Defined in Tension.swift
    case "Diagram":
        DiagramView() //Not yet built, defined above
    default:
        Text("Select a tab") // Required but doesn't get used
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
        
        //Used to return the preview of the Navigation View
        return NavigationView {
            ContentView(deflectionLog: sampleLog)
                .environment(\.managedObjectContext, context)
        }
    }
}
