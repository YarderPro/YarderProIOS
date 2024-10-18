//
//  AnchorSide.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/17/24.
//


import SwiftUI


struct AnchorSide: View {
    @ObservedObject var deflectionLog: DeflectionLog
    var body: some View {
        Text("Hello, World!")
    }
}

struct AnchorSide_Preview: PreviewProvider {
    static var previews: some View {
        VStack{
            let demoLog = DeflectionLog()
            AnchorSide(deflectionLog: demoLog)
        }
    }
}
