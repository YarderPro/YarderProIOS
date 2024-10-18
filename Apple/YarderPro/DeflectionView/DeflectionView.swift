//
//  DeflectionView.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/16/24.
//

//This is to change the background of text feilds

import SwiftUI



struct DeflectionView: View{
    @ObservedObject var deflectionLog: DeflectionLog
    var body:some View{
        AnchorYarder(deflectionLog: self.deflectionLog)
    }
}

struct AnchorYarder: View {
    @ObservedObject var deflectionLog: DeflectionLog

    var body: some View {
        VStack {
            Picker("Select a Tab", selection: $deflectionLog.yarderOrAnchor) {
                Text("Yarder").tag(DeflectionLog.YarderOrAnchor.yarder) // Use enum case directly
                Text("Anchor").tag(DeflectionLog.YarderOrAnchor.anchor) // Use enum case directly
            }
            .pickerStyle(.segmented)

            // Ensure deflectionLog is not nil and properly initialized
            slider(selectedTab: deflectionLog.yarderOrAnchor, deflectionLog: deflectionLog)
        }
    }
}


struct AnchorView: View{
    var body: some View{
        Text("Anchor View")
    }
}





@ViewBuilder
func slider(selectedTab: DeflectionLog.YarderOrAnchor, deflectionLog: DeflectionLog) -> some View {
    switch selectedTab {
    case .yarder:
        YarderSide(deflectionLog: deflectionLog) // Ensure this view does not cause crashes
    case .anchor:
        AnchorView() // Ensure this view does not cause crashes
    }
    Spacer()
}

struct DeflectionView_Preview: PreviewProvider{
    static var previews: some View {
        VStack{
            let demoLog = DeflectionLog()
            DeflectionView(deflectionLog: demoLog)
        }
    }
}

