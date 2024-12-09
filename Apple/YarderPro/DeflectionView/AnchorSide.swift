//
//  AnchorSide.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/17/24.
//


import SwiftUI
import CoreData

/*
 DESCRIPTION:
 This file creates the View for the anchor side of YarderPro. Anchor side is calculations done from the tailhold. The inputs are listed here as a form, all calculations are done within the DeflectionLogEntity class and can be modified there.
 */

struct AnchorSide: View {
    @ObservedObject var deflectionLog: DeflectionLogEntity
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isEditingTower: Bool = false
    @State private var isEditingMidSpan: Bool = false
    @State private var isEditingLength: Bool = false
    
    private var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        return formatter
    }
    
    var body: some View {
        Form{
            Section{
                HStack {
                    Spacer()
                    Text("Slope to Tower")
                        .font(.custom("Helvetica Neue", size: 19))
                        .frame(width: 150, height: 20)
                    
                    Spacer()
                    
                    // Use a temporary String to hold the input
                    
                    TextField("Tower", value: ($deflectionLog.slopeToTower), formatter: decimalFormatter, onEditingChanged: { isEditing in isEditingTower = isEditing})
                        .font(.custom("Helvetica Neue", size: 19))
                        .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingTower))
                        .keyboardType(.decimalPad)
                        .onChange(of: deflectionLog.slopeToTower) {
                            deflectionLog.calculateAnchorDeflection(context: viewContext)
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
                    Text("Slope to Mid Span")
                        .font(.custom("Helvetica Neue", size: 19))
                        .frame(width:150, height: 60)
                    
                    Spacer()
                    
                    TextField("Mid Span", value: ($deflectionLog.slopeToMid), formatter: decimalFormatter, onEditingChanged: { isEditing in isEditingMidSpan = isEditing})
                        .font(.custom("Helvetica Neue", size: 19))
                        .keyboardType(.decimalPad)
                        .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingMidSpan))
                        .onChange(of: deflectionLog.slopeToMid) {
                            deflectionLog.calculateAnchorDeflection(context: viewContext)
                        }
                        .overlay(
                            Text("%")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8),
                            alignment: .trailing
                        )
                }
                
                //Length section
                HStack{
                    Spacer()
                    Text("Length from \nAnchor to Tower")
                        .font(.custom("Helvetica Neue", size: 19))
                        .frame(width:150, height: 60)
                    
                    Spacer()
                    
                    TextField("Length", value: $deflectionLog.logLengthAnchor, formatter: decimalFormatter, onEditingChanged: { editing in
                        isEditingLength = editing
                    })
                    .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingLength))
                    .keyboardType(.decimalPad)
                    .font(.custom("Helvetica Neue", size: 19))
                    .onChange(of: deflectionLog.logLengthAnchor) {
                        deflectionLog.calculateAnchorDeflection(context: viewContext)
                    }
                }
            }
            
            
            //Section for deflection
            Section(header: Text("Anchor Side Deflection")){
                HStack {
                    Text("Deflection")
                        .font(.custom("Helvetica Neue", size: 19))
                    Spacer()
                    if deflectionLog.isDataValidAnchor {
                        // Display `percentDeflection` directly if it's a non-optional Double
                        Text("\(deflectionLog.percentDeflectionAnchor)")
                            .font(.custom("Helvetica Neue", size: 19))
                            .overlay(
                                Text("%")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8),
                                alignment: .trailing
                            )
                    } else {
                        Text("Not enough data entered")
                            .foregroundColor(.red)
                            .font(.custom("Helvetica Neue", size: 19))
                    }
                }
            }
        }
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


/*
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
}
*/
