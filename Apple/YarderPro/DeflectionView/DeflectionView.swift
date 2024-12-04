//
//  DeflectionView.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/16/24.
//


import SwiftUI
import CoreData

/*
 DESCRIPTION:
 To achieve the nested tab view in the View which calulates deflection using the anchor side and yarder side, YarderPro uses the DeflectionView file to arrange the tabs accordingly. Selection of a new tab will change the current view, the enum properties of this view could be repetative with DeflectionLogEnitity but messing with that could cause problems. For any issues with the Deflections tab or the Anchor Yarder tab this is the file to refrence. 
 */

struct DeflectionView: View {
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

