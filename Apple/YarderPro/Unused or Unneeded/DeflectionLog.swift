//
//  DeflectionLog.swift
//  Forestry
//
//  Created by Drew Hengehold on 9/24/24.
//

/*
 
 NO LONGER IN USE
 FILE DESCRIPTION:
 This file was created before the development of data persistence, the use of this file is no longer necissary, however, it is still prestn for refrence and context to the creation of the new DeflectionLogEntity.swift which drew inspiration from this file. 
 
 
import Foundation
import CoreData

class DeflectionLogWrapper: ObservableObject, Identifiable {
    @Published var logEntity: DeflectionLogEntity
    var context: NSManagedObjectContext

    init(logEntity: DeflectionLogEntity, context: NSManagedObjectContext) {
        self.logEntity = logEntity
        self.context = context
    }

    var id: NSManagedObjectID {
        return logEntity.objectID
    }

    var logName: String? {
        get { logEntity.logName }
        set {
            logEntity.logName = newValue
            saveContext()  // Save whenever value is updated
        }
    }

    var logDate: Date {
        get { logEntity.logDate ?? Date() }
        set {
            logEntity.logDate = newValue
            saveContext()
        }
    }

    var description: String? {
        get { logEntity.logDescription }
        set {
            logEntity.logDescription = newValue
            saveContext()
        }
    }

    var southCoord: Double? {
        get { logEntity.southCoord }
        set {
            logEntity.southCoord = newValue ?? 0
            saveContext()
        }
    }

    var northCoord: Double? {
        get { logEntity.northCoord }
        set {
            logEntity.northCoord = newValue ?? 0
            saveContext()
        }
    }

    var eastCoord: Double? {
        get { logEntity.eastCoord }
        set {
            logEntity.eastCoord = newValue ?? 0
            saveContext()
        }
    }

    var westCoord: Double? {
        get { logEntity.westCoord }
        set {
            logEntity.westCoord = newValue ?? 0
            saveContext()
        }
    }

    var spanGround: Double? {
        get { logEntity.spanGround }
        set {
            logEntity.spanGround = newValue ?? 0
            saveContext()
        }
    }

    var spanMidSpan: Double? {
        get { logEntity.spanMidSpan }
        set {
            logEntity.spanMidSpan = newValue ?? 0
            saveContext()
        }
    }

    var percentDeflection: Double? {
        get { logEntity.percentDeflection }
        set {
            logEntity.percentDeflection = newValue ?? 0
            saveContext()
        }
    }

    var towerHeight: Double? {
        get { logEntity.towerHeight }
        set {
            logEntity.towerHeight = newValue ?? 0
            saveContext()
        }
    }

    var logLength: Double? {
        get { logEntity.logLength }
        set {
            logEntity.logLength = newValue ?? 0
            saveContext()
        }
    }

    enum YarderOrAnchor: String, Hashable {
        case yarder = "Yarder"
        case anchor = "Anchor"
    }
    
    var yarderOrAnchor: DeflectionLogWrapper.YarderOrAnchor {
        get {
            DeflectionLogWrapper.YarderOrAnchor(rawValue: logEntity.yarderOrAnchor ?? "Yarder") ?? .yarder
        }
        set {
            logEntity.yarderOrAnchor = newValue.rawValue
            saveContext()
        }
    }

    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: logDate)
    }

    var isDataValid: Bool {
        return spanGround != nil && spanMidSpan != nil && towerHeight != nil && logLength != nil
    }

    func calculatePercentDeflection() {
        let spanGroundValue = spanGround ?? 0.0
        let spanMidSpanValue = spanMidSpan ?? 0.0
        let towerHeightValue = towerHeight ?? 0.0
        
        guard let lengthValue = logLength, lengthValue != 0 else {
            percentDeflection = nil
            return
        }

        percentDeflection = (abs(spanGroundValue - spanMidSpanValue ) / 2.2) + (towerHeightValue / lengthValue) / 2.2 * 100
        saveContext()
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}


*/

//import Foundation
//import Combine
//
//class DeflectionLog: ObservableObject, Identifiable{
//    //Each log must be unique to be listed so we need a unique ID
//    var id = UUID()
//    // All the variables used in the detail tab
//    @Published var logName: String? = nil
//    @Published var logDate: Date = Date()
//    @Published var description: String? = nil
//    @Published var southCoord: Double? = nil
//    @Published var northCoord: Double? = nil
//    @Published var eastCoord: Double? = nil
//    @Published var westCoord: Double? = nil
//    
//    var dateFormatted: String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter.string(from: logDate)
//    }
//    
//    //All the variables used in the deflection calculator tab
//    //% Deflection = (Sground– Smidspan) / 2.2 + (TowerH / Length) / 2.2 x 100%
//    @Published var spanGround: Double? = nil
//    @Published var spanMidSpan: Double? = nil
//    @Published var percentDeflection: Double? = 0
//    @Published var TowerHeight: Double? = nil
//    @Published var Length: Double? = nil
//    
//    //Variable to remember yarder or anchor side
//    
//    enum YarderOrAnchor: String, Hashable {
//            case yarder = "Yarder"
//            case anchor = "Anchor"
//        }
//        
//    @Published var yarderOrAnchor: YarderOrAnchor = .yarder
//
//    var isDataValid: Bool {
//        return spanGround != nil && spanMidSpan != nil && TowerHeight != nil && Length != nil
//    }
//    
//    func calculatePercentDeflection() {
//           // Unwrapping with default values if necessary
//           let spanGroundValue = spanGround ?? 0.0
//           let spanMidSpanValue = spanMidSpan ?? 0.0
//           let towerHeightValue = TowerHeight ?? 0.0
//           let lengthValue = Length ?? 1.0 // Avoid division by zero
//
//           // Ensure length is not zero to prevent division by zero error
//           guard lengthValue != 0 else {
//               percentDeflection = nil
//               return
//           }
//
//           // Calculate percent deflection
//           percentDeflection = (abs(spanGroundValue - spanMidSpanValue) / 2.2) + (towerHeightValue / lengthValue) / 2.2 * 100
//       }
//
//    
//    
//    //All variables for the tension tab
//    
//    //All variables for the Diagram Tap
//    
//    //All Variables for the Map Tab
//}
