//
//  DeflectionView.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/16/24.
//

//This is to change the background of text feilds

import SwiftUI
import CoreData

struct DeflectionView: View {
    @ObservedObject var deflectionLog: DeflectionLogEntity
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        AnchorYarder(deflectionLog: deflectionLog)
    }
}

struct AnchorYarder: View {
    @ObservedObject var deflectionLog: DeflectionLogEntity
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            // Picker with enum options
            Picker("Select a Tab", selection: Binding(
                get: { deflectionLog.yarderOrAnchorEnum },
                set: { newValue in
                    deflectionLog.yarderOrAnchorEnum = newValue
                    saveContext()
                }
            )) {
                Text("Yarder").tag(YarderOrAnchor.yarder)
                Text("Anchor").tag(YarderOrAnchor.anchor)
            }
            .pickerStyle(.segmented)

            // Slider for different views based on selected tab
            slider(selectedTab: deflectionLog.yarderOrAnchorEnum, deflectionLog: deflectionLog)
        }
    }

    private func saveContext() {
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
}

enum YarderOrAnchor: String, CaseIterable {
    case yarder, anchor
}

// Add computed property in DeflectionLogEntity to bridge enum to String
extension DeflectionLogEntity {
    var yarderOrAnchorEnum: YarderOrAnchor {
        get { YarderOrAnchor(rawValue: yarderOrAnchor ?? "") ?? .yarder }
        set { yarderOrAnchor = newValue.rawValue }
    }
}

// Slider view that changes based on selection
@ViewBuilder
func slider(selectedTab: YarderOrAnchor, deflectionLog: DeflectionLogEntity) -> some View {
    switch selectedTab {
    case .yarder:
        YarderSide(deflectionLog: deflectionLog)
    case .anchor:
        AnchorSide(deflectionLog: deflectionLog)
    }
}

