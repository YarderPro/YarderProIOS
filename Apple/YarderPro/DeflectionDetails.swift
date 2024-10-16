//
//  DeflectionDetails.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/16/24.
//

import SwiftUI

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


struct DeflectionDetails_Preview: PreviewProvider{
    static var previews: some View {
        VStack{
            let demoLog = DeflectionLog()
            DeflectionDetails(deflectionLog: demoLog)
        }
    }
}
