//
//  DeflectionDetails.swift
//  Forestry
//
//  Created by Drew Hengehold on 9/24/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Deflections"
    @ObservedObject var deflectionLog: DeflectionLog
    
    var body: some View {
        VStack {
            Picker("Select a Tab", selection: $selectedTab) {
                Text("Details").tag("Details")
                Text("Deflections").tag("Deflections")
                Text("Tension").tag("Tension")
                Text("Diagram").tag("Diagram")
            }
           .pickerStyle(.segmented)
            
            TabContent(selectedTab: selectedTab, deflectionLog: self.deflectionLog)
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
func TabContent(selectedTab: String, deflectionLog: DeflectionLog) -> some View {
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

struct ContentView_Preview: PreviewProvider{
    static var previews: some View {
        VStack{
            let demoLog = DeflectionLog()
            ContentView(deflectionLog: demoLog)
        }
    }
}
