//
//  DeflectionView.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/16/24.
//

//This is to change the background of text feilds

import SwiftUI


struct CustomBorderedTextFieldStyle: TextFieldStyle {
    var isEditing: Bool

    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(7)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isEditing ? Color.blue : Color.gray, lineWidth: 2)
                    .background(Color.white)
                    .cornerRadius(8)
            )
            .padding([.leading, .trailing], 2)
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

struct DeflectionViewSettup: View{
    @ObservedObject var deflectionLog: DeflectionLog
    var body:some View{
        AnchorYarder(deflectionLog: self.deflectionLog)
    }
}

struct DeflectionView: View{
    @ObservedObject var deflectionLog: DeflectionLog
    
    @State private var isEditingGround: Bool = false
    @State private var isEditingMidSpan: Bool = false
    @State private var isEditingTowerHeight: Bool = false
    @State private var isEditingLength: Bool = false
    
    private var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        return formatter
    }
    
    var body: some View{
        VStack{
            Form{
                Section{
                    HStack {
                        Spacer()
                        Text("Angle to Ground")
                            .font(.custom("Helvetica Neue", size: 19))
                            .frame(width: 150, height: 20)
                        
                        Spacer()
                        
                        // Use a temporary String to hold the input
                        
                        TextField("Ground", value: ($deflectionLog.spanGround), formatter: decimalFormatter, onEditingChanged: { isEditing in isEditingGround = isEditing})
                            .font(.custom("Helvetica Neue", size: 19))
                            .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingGround))
                            .onChange(of: deflectionLog.spanGround) {
                                deflectionLog.calculatePercentDeflection()
                            }
                            .overlay(
                                Text("%")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8),
                                alignment: .trailing
                            )
                    }
                    
                    
                    HStack{
                        Spacer()
                        Text("Angle to Tailhold")
                            .font(.custom("Helvetica Neue", size: 19))
                            .frame(width:150, height: 20)
                        
                        Spacer()
                        
                        TextField("Mid Span", value: ($deflectionLog.spanMidSpan), formatter: decimalFormatter, onEditingChanged: { isEditing in isEditingMidSpan = isEditing})
                            .font(.custom("Helvetica Neue", size: 19))
                            .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingMidSpan))
                            .onChange(of: deflectionLog.spanMidSpan) {
                                deflectionLog.calculatePercentDeflection()
                            }
                            .overlay(
                                Text("%")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8),
                                alignment: .trailing
                            )
                    }
                    
                    HStack{
                        Spacer()
                        Text("Tower Height")
                            .font(.custom("Helvetica Neue", size: 19))
                            .frame(width:150, height: 20)
                        
                        Spacer()
                        
                        TextField("Tower Height", value: $deflectionLog.TowerHeight, formatter: decimalFormatter, onEditingChanged: { editing in
                            isEditingTowerHeight = editing
                        })
                        .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingTowerHeight))
                        .keyboardType(.decimalPad)
                        .font(.custom("Helvetica Neue", size: 19))
                        .onChange(of: deflectionLog.TowerHeight) {
                            deflectionLog.calculatePercentDeflection()
                        }
                    }
                    
                    HStack{
                        Spacer()
                        Text("Length of Cable")
                            .font(.custom("Helvetica Neue", size: 19))
                            .frame(width:150, height: 20)
                        
                        Spacer()
                        
                        TextField("Length", value: $deflectionLog.Length, formatter: decimalFormatter, onEditingChanged: { editing in
                            isEditingLength = editing
                        })
                        .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingLength))
                        .keyboardType(.decimalPad)
                        .font(.custom("Helvetica Neue", size: 19))
                        .onChange(of: deflectionLog.Length) {
                            deflectionLog.calculatePercentDeflection()
                        }
                    }
                }
                
                //Section for deflection
                Section{
                    HStack {
                        Text("Deflection")
                            .font(.custom("Helvetica Neue", size: 19))
                        Spacer()
                        if deflectionLog.isDataValid {
                            if let deflection = deflectionLog.percentDeflection {
                                Text("\(deflection)")  // Safe unwrapping
                                    .font(.custom("Helvetica Neue", size: 19))
                            } else {
                                Text("No deflection calculated")
                                    .foregroundColor(.red)
                                    .font(.custom("Helvetica Neue", size: 19))
                            }
                        } else {
                            Text("Not enough data entered")
                                .foregroundColor(.red)
                                .font(.custom("Helvetica Neue", size: 19))
                        }
                    }
                }
                .pickerStyle(.inline)
            }
        }
    }
}

@ViewBuilder
func slider(selectedTab: DeflectionLog.YarderOrAnchor, deflectionLog: DeflectionLog) -> some View {
    switch selectedTab {
    case .yarder:
        DeflectionView(deflectionLog: deflectionLog) // Ensure this view does not cause crashes
    case .anchor:
        AnchorView() // Ensure this view does not cause crashes
    }
    Spacer()
}

struct DeflectionView_Preview: PreviewProvider{
    static var previews: some View {
        VStack{
            let demoLog = DeflectionLog()
            DeflectionViewSettup(deflectionLog: demoLog)
        }
    }
}

