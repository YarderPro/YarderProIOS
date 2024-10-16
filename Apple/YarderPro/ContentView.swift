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

//This is to change the background of text feilds
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
    
struct DeflectionDetails: View{
    @ObservedObject var deflectionLog: DeflectionLog
    
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
                
                TextField(
                    " Calculation name",
                    text: $deflectionLog.logName
                )
                .border(.secondary)
                .border(Color.gray)
                .padding(.leading, 2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.trailing, 20)
                .cornerRadius(3)
                .frame(minWidth:0, maxWidth:.infinity)
                .font(.custom("Helvetica Neue", size: 19))
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
                
                TextField(
                    " Description",
                    text: $deflectionLog.description
                )
                .border(.secondary)
                .border(Color.gray)
                .padding(.leading, 2)
                .padding(.trailing, 20)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(3)
                .frame(minWidth:0, maxWidth:.infinity)
                .font(.custom("Helvetica Neue", size: 19))
            }
            .padding(.bottom, 40)
            
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
        }
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

struct DeflectionDetails_Preview: PreviewProvider{
    static var previews: some View {
        VStack{
            let demoLog = DeflectionLog()
            ContentView(deflectionLog: demoLog)
        }
    }
}
