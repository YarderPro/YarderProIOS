//
//  DeflectionLogsView.swift
//  Forestry
//
//  Created by Drew Hengehold on 9/24/24.
//
import SwiftUI
import CoreData

struct DeflectionLogsView: View{
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = DeflectionLogsViewModel(context: PersistenceController.shared.persistenceContainer.viewContext)
    @State private var isButtonPressed = false
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: DeflectionLogsViewModel(context: context))
    }
    
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
                List(viewModel.deflectionLogs) { log in
                    NavigationLink(destination: ContentView(deflectionLog: log)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(log.logName ?? "New Log")
                                    .font(.title2)
                                    .bold()
                                Text(log.logDescription ?? "New Log Description")
                            }
                            Spacer()
                            Text(log.logDate.formatted()) // Assuming you want to format the date
                        }
                    }
                }
                .listStyle(.grouped)
                .onAppear{ 
                    viewModel.fetchDeflectionLogs()
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

#if DEBUG || TRACE_RESOURCES
    struct DeflectionLogsView_Previews: PreviewProvider {
        static var previews: some View {
            let context = PersistenceController.preview.persistenceContainer.viewContext
            return NavigationView {
                DeflectionLogsView(context: context)
                    .environment(\.managedObjectContext, context)
            }
        }
    }
#endif
