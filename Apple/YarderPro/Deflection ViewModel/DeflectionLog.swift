//
//  DeflectionLog.swift
//  Forestry
//
//  Created by Drew Hengehold on 9/24/24.
//
import Foundation
import Combine

class DeflectionLog: ObservableObject, Identifiable{
    //Each log must be unique to be listed so we need a unique ID
    var id = UUID()
    // All the variables used in the detail tab
    @Published var logName: String = ""
    @Published var logDate: Date = Date()
    @Published var description: String = ""
    @Published var southCoord: Double? = nil
    @Published var northCoord: Double? = nil
    @Published var eastCoord: Double? = nil
    @Published var westCoord: Double? = nil
    
    //All the variables used in the deflection calculator tab
    //% Deflection = (Sground– Smidspan) / 2.2 + (TowerH / Length) / 2.2 x 100%
    @Published var spanGround: Double? = nil
    @Published var spanMidSpan: Double? = nil
    @Published var percentDeflection: Double? = 0
    @Published var TowerHeight: Double? = nil
    @Published var Length: Double? = nil
    
    var isDataValid: Bool {
        return spanGround != nil && spanMidSpan != nil && TowerHeight != nil && Length != nil
    }
    
    func calculatePercentDeflection() {
           // Unwrapping with default values if necessary
           let spanGroundValue = spanGround ?? 0.0
           let spanMidSpanValue = spanMidSpan ?? 0.0
           let towerHeightValue = TowerHeight ?? 0.0
           let lengthValue = Length ?? 1.0 // Avoid division by zero

           // Ensure length is not zero to prevent division by zero error
           guard lengthValue != 0 else {
               percentDeflection = nil
               return
           }

           // Calculate percent deflection
           percentDeflection = (abs(spanGroundValue - spanMidSpanValue) / 2.2) + (towerHeightValue / lengthValue) / 2.2 * 100
       }

    
    
    //All variables for the tension tab
    
    //All variables for the Diagram Tap
    
    //All Variables for the Map Tab
}
