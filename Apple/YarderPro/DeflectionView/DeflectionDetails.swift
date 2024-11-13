//
//  DeflectionDetails.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/16/24.
//

import SwiftUI

struct DeflectionDetails: View{
    @ObservedObject var deflectionLog: DeflectionLogEntity
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isEditingDescription: Bool = false
    @State private var isEditingName: Bool = false
    @FocusState private var isFocusedDescription: Bool
    
    var body: some View{
        VStack{
            Text("Calculation Details")
                .font(.custom("Helvetica Neue", size: 30))
                .frame(maxWidth:.infinity, alignment:.leading)
                .fontWeight(.bold)
                .padding(.leading, 8)
            
            //Name
            HStack{
                Spacer()
                Text("Name")
                    .frame(minWidth:0, maxWidth:.infinity, alignment:.trailing)
                    .font(.custom("Helvetica Neue", size: 20))
                    .padding(.trailing, 10)
                    .foregroundColor(Color(.gray))
                
                TextField("Log Name", text: $deflectionLog.logName, onEditingChanged: { editing in
                    isEditingName = editing
                })
                .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isEditingName))
                .font(.custom("Helvetica Neue", size: 19))
                .onChange(of: deflectionLog.logName) {
                    do {
                        try viewContext.save()
                    } catch {
                        print("Failed to save context: \(error)")
                    }
                }
            }
            
            
            
            //Date
            HStack{
                Spacer(minLength: 134)
                DatePicker("Date", selection: $deflectionLog.logDate, displayedComponents:.date)
                    .datePickerStyle(.compact)
                    .font(.custom("Helvetica Neue", size: 19))
                    .foregroundColor(Color(.gray))
                Spacer(minLength: 50)
            }
            .padding([.leading, .trailing])
            
            
            
            //Description
            HStack{
                Spacer()
                Text("Description")
                    .frame(minWidth:0, maxWidth:.infinity, alignment:.trailing)
                    .font(.custom("Helvetica Neue", size: 20))
                    .padding(.trailing, 10)
                    .foregroundColor(Color(.gray))

                TextField("Log Description", text: $deflectionLog.logDescription, axis: .vertical)
                    .textFieldStyle(CustomBorderedTextFieldStyle(isEditing: isFocusedDescription))
                    .font(.custom("Helvetica Neue", size: 19))
                    .focused($isFocusedDescription)
                    .onChange(of: isFocusedDescription) {
                        isEditingDescription = false
                    }
                    .onChange(of: deflectionLog.logDescription) {
                        do {
                            try viewContext.save()
                        } catch {
                            print("Failed to save context: \(error)")
                        }
                    }
            }
            .padding(.bottom, 40)
            
            // THESE CAN BE ADDED LATER FOR LOCATION CONTROL IF NEEDED
            
            /*
            //North Coordinate
            HStack{
                Spacer()
                Text("North Coordinate")
                    .frame(minWidth:0, maxWidth:.infinity, alignment:.trailing)
                    .font(.custom("Helvetica Neue", size: 20))
                    .padding(.trailing, 10)
                    .foregroundColor(Color(.gray))
                
                TextField(
                    " North Coordinate",
                    value: $deflectionLog.northCoord,
                    formatter: NumberFormatter()
                )
                .border(.secondary)
                .border(Color.gray)
                .padding(.leading, 2)
                .padding(.trailing, 20)
                .cornerRadius(3)
                .frame(minWidth:0, maxWidth:.infinity)
                .font(.custom("Helvetica Neue", size: 19))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            //South Coordinate
            HStack{
                Spacer()
                Text("South Coordinate")
                    .frame(minWidth:0, maxWidth:.infinity, alignment:.trailing)
                    .font(.custom("Helvetica Neue", size: 20))
                    .padding(.trailing, 10)
                    .foregroundColor(Color(.gray))
                
                TextField(
                    " South Coordinate",
                    value: $deflectionLog.southCoord,
                    formatter: NumberFormatter()
                )
                .border(.secondary)
                .border(Color.gray)
                .padding(.leading, 2)
                .padding(.trailing, 20)
                .cornerRadius(3)
                .frame(minWidth:0, maxWidth:.infinity)
                .font(.custom("Helvetica Neue", size: 19))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            //East Coordinate
            HStack{
                Spacer()
                Text("East Coordinate")
                    .frame(minWidth:0, maxWidth:.infinity, alignment:.trailing)
                    .font(.custom("Helvetica Neue", size: 20))
                    .padding(.trailing, 10)
                    .foregroundColor(Color(.gray))
                
                TextField(
                    " East Coordinate",
                    value: $deflectionLog.eastCoord,
                    formatter: NumberFormatter()
                )
                .border(.secondary)
                .border(Color.gray)
                .padding(.leading, 2)
                .padding(.trailing, 20)
                .cornerRadius(3)
                .frame(minWidth:0, maxWidth:.infinity)
                .font(.custom("Helvetica Neue", size: 19))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            //West Coordinate
            HStack{
                Spacer()
                Text("West Coordinate")
                    .frame(minWidth:0, maxWidth:.infinity, alignment:.trailing)
                    .font(.custom("Helvetica Neue", size: 20))
                    .padding(.trailing, 10)
                    .foregroundColor(Color(.gray))
                
                TextField(
                    " West Coordinate",
                    value: $deflectionLog.westCoord,
                    formatter: NumberFormatter()
                )
                .border(.secondary)
                .border(Color.gray)
                .padding(.leading, 2)
                .padding(.trailing, 20)
                .cornerRadius(3)
                .frame(minWidth:0, maxWidth:.infinity)
                .font(.custom("Helvetica Neue", size: 19))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Spacer()
             */
            
            Spacer()
        }
    }
}


struct DeflectionDetails_Preview: PreviewProvider{
    static var previews: some View {
        // Use the preview PersistenceController context for testing
        let context = PersistenceController.preview.persistenceContainer.viewContext
        
        // Create a sample DeflectionLogEntity for preview purposes
        let sampleLog = DeflectionLogEntity(context: context)
        sampleLog.logName = "Sample Log"
        sampleLog.logDescription = "This is a sample log description."
        sampleLog.logDate = Date()
        
        return NavigationView {
            DeflectionDetails(deflectionLog: sampleLog)
                .environment(\.managedObjectContext, context)
        }
    }
}
