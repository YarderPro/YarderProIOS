//
//  DeflectionView.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/17/24.
//

import SwiftUI

struct YarderSide: View{
    @ObservedObject var deflectionLog: DeflectionLogEntity
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isEditingGround: Bool = false
    @State private var isEditingMidSpan: Bool = false
    @State private var isEditingTowerHeight: Bool = false
    @State private var isEditingLength: Bool = false
    
//    @State private var buttonHeight: Bool = false
//    @State private var buttonLength: Bool = false
    
    private var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        return formatter
    }
    
    var body: some View{
        Form{
            Section{
                HStack {
                    Spacer()
                    Text("Slope to Mid Span")
                        .font(.custom("Helvetica Neue", size: 19))
                        .frame(width: 150, height: 50)
                    
                    Spacer()
                    
                    // Use a temporary String to hold the input
                    
                    TextField("Ground", value: ($deflectionLog.spanGround), formatter: decimalFormatter, onEditingChanged: { isEditing in isEditingGround = isEditing})
                        .font(.custom("Helvetica Neue", size: 19))
                        .keyboardType(.decimalPad)
                        .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingGround))
                        .onChange(of: deflectionLog.spanGround) {
                            deflectionLog.calculatePercentDeflection(context: viewContext)
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
                    Text("Slope to Tailhold")
                        .font(.custom("Helvetica Neue", size: 19))
                        .frame(width:150, height: 20)
                    
                    Spacer()
                    
                    TextField("Mid Span", value: ($deflectionLog.spanMidSpan), formatter: decimalFormatter, onEditingChanged: { isEditing in isEditingMidSpan = isEditing})
                        .font(.custom("Helvetica Neue", size: 19))
                        .keyboardType(.decimalPad)
                        .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingMidSpan))
                        .onChange(of: deflectionLog.spanMidSpan) {
                            deflectionLog.calculatePercentDeflection(context: viewContext)
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
                    
                    TextField("Tower Height", value: $deflectionLog.towerHeight, formatter: decimalFormatter, onEditingChanged: { editing in
                        isEditingTowerHeight = editing
                    })
                    .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingTowerHeight))
                    .keyboardType(.decimalPad)
                    .font(.custom("Helvetica Neue", size: 19))
                    .onChange(of: deflectionLog.towerHeight) {
                        deflectionLog.calculatePercentDeflection(context: viewContext)
                    }
                    
                    // Meter v Yard toggle
//                    Toggle(isOn: $buttonHeight, label: {
//                        HStack {
//                            Spacer()
//                            if(buttonHeight == true){
//                                Image(systemName: "y.square")
//                                    .foregroundColor(.green)
//                                    .font(.system(size: 20))
//                            }
//                            else{
//                                Image(systemName: "m.square")
//                                    .foregroundColor(.gray)
//                                    .font(.system(size: 20))
//                            }
//                        }
//                    })
                }
                
                HStack{
                    Spacer()
                    Text("Length from \nTower to Anchor")
                        .font(.custom("Helvetica Neue", size: 19))
                        .frame(width:150, height: 60)
                    
                    Spacer()
                    
                    TextField("Length", value: $deflectionLog.logLength, formatter: decimalFormatter, onEditingChanged: { editing in
                        isEditingLength = editing
                    })
                    .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingLength))
                    .keyboardType(.decimalPad)
                    .font(.custom("Helvetica Neue", size: 19))
                    .onChange(of: deflectionLog.logLength) {
                        deflectionLog.calculatePercentDeflection(context: viewContext)
                    }
                    // Meter v Yard toggle
//                    Toggle(isOn: $buttonLength, label: {
//                        HStack {
//                            Spacer()
//                            if(buttonLength == true){
//                                Image(systemName: "y.square")
//                                    .foregroundColor(.green)
//                                    .font(.system(size: 20))
//                            }
//                            else{
//                                Image(systemName: "m.square")
//                                    .foregroundColor(.gray)
//                                    .font(.system(size: 20))
//                            }
//                        }
//                    })
                }
            }
            
            
            //Section for deflection
            Section(header: Text("Yarder Side Deflection")){
                HStack {
                    Text("Deflection")
                        .font(.custom("Helvetica Neue", size: 19))
                    Spacer()
                    if deflectionLog.isDataValidYarder {
                        // Display `percentDeflection` directly if it's a non-optional Double
                        Text("\(deflectionLog.percentDeflection)")
                            .font(.custom("Helvetica Neue", size: 19))
                    }else if(deflectionLog.logLength == 0){
                        Text("Log Length Must not be 0")
                            .foregroundColor(.red)
                            .font(.custom("Helvetica Neue", size: 19))
                    }else if(deflectionLog.spanMidSpan >= 90){
                        Text("MidSpan Slope must be less than 90")
                            .foregroundColor(.red)
                            .font(.custom("Helvetica Neue", size: 19))
                    }else if(deflectionLog.spanGround >= 90){
                        Text("Ground Slope must be less than 90")
                            .foregroundColor(.red)
                            .font(.custom("Helvetica Neue", size: 19))
                    }else{
                        Text("Enter all values")
                            .foregroundColor(.red)
                            .font(.custom("Helvetica Neue", size: 19))
                    }
                }
            }
        }
    }
}

struct YarderSide_Preview: PreviewProvider {
    static var previews: some View {
        // Use the preview PersistenceController context for testing
        let context = PersistenceController.preview.persistenceContainer.viewContext
        
        // Create a sample DeflectionLogEntity for preview purposes
        let sampleLog = DeflectionLogEntity(context: context)
        sampleLog.logName = "Sample Log"
        sampleLog.logDescription = "This is a sample log description."
        sampleLog.logDate = Date()
        
        return NavigationView {
            YarderSide(deflectionLog: sampleLog)
                .environment(\.managedObjectContext, context)
        }
    }
}
