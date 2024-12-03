//
//  Tension.swift
//  YarderPro
//
//  Created by Drew Hengehold on 12/2/24.
//

import SwiftUI

//Cable Tension = (Length M * Load KG) / (4 * deflection in M) + (weight per unit length kg * Length m ^2) / (8 * deflection in M)

struct Tension: View{
    @ObservedObject var deflectionLog: DeflectionLogEntity
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isEditingLoad: Bool = false
    @State private var isEditingCableWeight: Bool = false
    @State private var isEditingDeflection: Bool = false
    @State private var isEditingLength: Bool = false
    
    //Variable used to check if the user is doing a yarder or anchor calculation, needed to know which length and deflection to us
    private var settingDeflection: Bool {
        if(deflectionLog.yarderType == .yarder){
            deflectionLog.calculateMidSpanDeflection(context: viewContext, deflection: deflectionLog.percentDeflection, length: deflectionLog.logLength)
            return true
        }else{
            deflectionLog.calculateMidSpanDeflection(context: viewContext, deflection: deflectionLog.percentDeflectionAnchor, length: deflectionLog.logLengthAnchor)
            return false
        }
    }
    
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
                    Text("Total Load Including Carriage (kg)")
                        .font(.custom("Helvetica Neue", size: 19))
                        .frame(width: 150, height: 80)
                    
                    Spacer()
                    
                    // Use a temporary String to hold the input
                    
                    TextField("Load in kg", value: ($deflectionLog.totalLoad), formatter: decimalFormatter, onEditingChanged: { isEditing in isEditingLoad = isEditing})
                        .font(.custom("Helvetica Neue", size: 19))
                        .keyboardType(.decimalPad)
                        .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingLoad))
                        .onChange(of: deflectionLog.totalLoad) {
                            deflectionLog.calculateTension(context: viewContext, deflectionType: settingDeflection)
                        }
                }
                
                
                HStack{
                    Spacer()
                    Text("Weight of \nCable per \nUnit Length \n(kg)")
                        .font(.custom("Helvetica Neue", size: 19))
                        .frame(width:150, height: 100)
                    
                    Spacer()
                    
                    TextField("Cable Weight (kg)", value: ($deflectionLog.cableWeight), formatter: decimalFormatter, onEditingChanged: { isEditing in isEditingCableWeight = isEditing})
                        .font(.custom("Helvetica Neue", size: 19))
                        .keyboardType(.decimalPad)
                        .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingCableWeight))
                        .onChange(of: deflectionLog.cableWeight) {
                            deflectionLog.calculateTension(context: viewContext, deflectionType: settingDeflection)
                        }
                }
                
                HStack{
                    Spacer()
                    Text("Length of \nCable (m)")
                        .font(.custom("Helvetica Neue", size: 19))
                        .frame(width:150, height: 50)
                    
                    Spacer()
                    
                    //Need to make sure that the length being edited is the correct one, are we in Yarder or Anchor mode
                    if(settingDeflection == true){
                        TextField("Length in Meters", value: $deflectionLog.logLength, formatter: decimalFormatter, onEditingChanged: { editing in
                            isEditingLength = editing
                        })
                        .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingLength))
                        .keyboardType(.decimalPad)
                        .font(.custom("Helvetica Neue", size: 19))
                        .onChange(of: deflectionLog.logLength) {
                            deflectionLog.calculateTension(context: viewContext, deflectionType: settingDeflection)
                        }
                    }else{
                        TextField("Length in Meters", value: $deflectionLog.logLengthAnchor, formatter: decimalFormatter, onEditingChanged: { editing in
                            isEditingLength = editing
                        })
                        .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingLength))
                        .keyboardType(.decimalPad)
                        .font(.custom("Helvetica Neue", size: 19))
                        .onChange(of: deflectionLog.logLengthAnchor) {
                            deflectionLog.calculateTension(context: viewContext, deflectionType: settingDeflection)
                        }
                    }
                }
                
                HStack{
                    Spacer()
                    Text("Midspan Deflection (m)")
                        .font(.custom("Helvetica Neue", size: 19))
                        .frame(width:150, height: 50)
                    
                    Spacer()
                    
                    TextField("Midspan Deflection (m)", value: $deflectionLog.midSpanDeflection, formatter: decimalFormatter, onEditingChanged: { editing in
                        isEditingDeflection = editing
                    })
                    .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingDeflection))
                    .keyboardType(.decimalPad)
                    .font(.custom("Helvetica Neue", size: 19))
                    .onChange(of: deflectionLog.midSpanDeflection) {
                        deflectionLog.calculateTension(context: viewContext, deflectionType: settingDeflection)
                    }
                }
            }
            
            
            //Section for deflection
            Section{
                HStack {
                    Text("Cable\nTension")
                        .font(.custom("Helvetica Neue", size: 19))
                    Spacer()
                    if deflectionLog.isDataValidYarder {
                        // Display `percentDeflection` directly if it's a non-optional Double
                        Text("\(deflectionLog.tension)")
                            .font(.custom("Helvetica Neue", size: 19))
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

struct Tesion_Preview: PreviewProvider {
    static var previews: some View {
        // Use the preview PersistenceController context for testing
        let context = PersistenceController.preview.persistenceContainer.viewContext
        
        // Create a sample DeflectionLogEntity for preview purposes
        let sampleLog = DeflectionLogEntity(context: context)
        sampleLog.logName = "Sample Log"
        sampleLog.logDescription = "This is a sample log description."
        sampleLog.logDate = Date()
        
        return NavigationView {
            Tension(deflectionLog: sampleLog)
                .environment(\.managedObjectContext, context)
        }
    }
}
