//
//  DeflectionViewModel.swift
//  Forestry
//
//  Created by Drew Hengehold on 9/24/24.
//

import Foundation

// This class stores the viewmodels for the deflection lgos
class DeflectionLogsViewModel: ObservableObject{
    @Published var deflectionLogs: [DeflectionLog] = []
    
    func addDeflectionLog() {
        let newLog = DeflectionLog()
        deflectionLogs.append(newLog)
    }
}

