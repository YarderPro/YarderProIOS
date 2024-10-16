//
//  DeflectionList.swift
//  Forestry
//
//  Created by Drew Hengehold on 9/24/24.
//
import SwiftUI


struct DeflectionLogsView: View{
    @StateObject var viewModel = DeflectionLogsViewModel()
    @State private var isButtonPressed = false
    
    var body: some View{
        //Place header and list on the VStack
        NavigationView{
            VStack(spacing:0){
                
                
                    //Setting up the header
                    HStack(alignment:.top){
                        
                        //This HStack is used for all calculations and number of calcs
                        VStack(alignment:.leading){
                            Text("All Calculations")
                                .font(.custom("Helvetica Neue", size: 24))
                                .fontWeight(.bold)
                            Text("\(viewModel.deflectionLogs.count) calculations")
                                .font(.custom("Helvetica Neue", size: 18))
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 9)
                        
                        
                        
                        //Spacer to put button and calculation texts on different sides
                        Spacer()
                        
                        
                        
                        //Setting up the button for add new calculation
                        Button(action: {
                            withAnimation {
                                isButtonPressed = true
                                //this adds in an animation for the button
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation {
                                        isButtonPressed = false
                                        viewModel.addDeflectionLog()
                                    }
                                }
                            }
                        }) {
                            Image(systemName: "plus")
                                .padding(15)
                                .padding([.leading,.trailing], 43)
                                .background(isButtonPressed ? Color.green : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.trailing, 9)
                    }
                    // End of HStack for header
                    
                
                
                    
                    //Start of list of relevant objects
                    List{
                        ForEach(viewModel.deflectionLogs){ log in
                            NavigationLink(destination: ContentView(deflectionLog: log)) {
                                Text(log.logName)
                            }
                        }
                    }
                    .listStyle(.grouped)
                    Spacer()
                }
                .navigationBarHidden(true)
            }
    }
}

struct DeflectionLogsView_Preview: PreviewProvider{
    static var previews: some View {
        NavigationView{
            DeflectionLogsView()
        }
    }
}
