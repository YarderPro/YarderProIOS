//
//  DeflectionLogEntity.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/18/24.
//
//

import Foundation
import CoreData


extension DeflectionLogEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeflectionLogEntity> {
        return NSFetchRequest<DeflectionLogEntity>(entityName: "DeflectionLogEntity")
    }

    //Coordinate variables used to describe location. Future uses would be to save the location of a calculation on a map, this implimentation requires more time and effort.
    @NSManaged public var eastCoord: Double
    @NSManaged public var westCoord: Double
    @NSManaged public var southCoord: Double
    @NSManaged public var northCoord: Double
    
    //Values used to calculate deflection on the yarder side, ground, midspan, height, length, and deflection from the yarder side.
    @NSManaged public var spanGround: Double
    @NSManaged public var spanMidSpan: Double
    @NSManaged public var towerHeight: Double
    @NSManaged public var logLength: Double
    @NSManaged public var percentDeflection: Double
    
    //Values used to calculate deflection on the anchor side
    @NSManaged public var slopeToTower: Double
    @NSManaged public var slopeToMid: Double
    @NSManaged public var logLengthAnchor: Double
    @NSManaged public var percentDeflectionAnchor: Double
    
    //Values used to calculate Tension
    @NSManaged public var tension: Double
    @NSManaged public var cableWeight: Double
    @NSManaged public var totalLoad: Double
    @NSManaged public var midSpanDeflection: Double
    
    //To keep the entity identifiable we need an id
    @NSManaged public var id: UUID
    
    //These are unique to each log, they show date, description, and name.
    @NSManaged public var logDate: Date
    @NSManaged public var logDescription: String
    @NSManaged public var logName: String
    
    
    //Used to remeber if the calculation was anchor side or yarder side
    @NSManaged public var yarderOrAnchor: String?
    
    // Enumerate between yarder and anchor
    public enum YarderType: String {
        case yarder
        case anchor
    }

    //Yarder type put the two elements above together, saving the yarder value in the string variable
    public var yarderType: YarderType {
        get {
            YarderType(rawValue: yarderOrAnchor ?? "") ?? .yarder
            // Default to `.yarder` if nil
        }
        set {
            yarderOrAnchor = newValue.rawValue
        }
    }
    
    
    // Used to calculate percent deflection on the yarder Side, uses equation % Deflection = (Sground– Smidspan) / 2.2 + (TowerH / Length) / 2.2 x 100%
    public func calculatePercentDeflection(context: NSManagedObjectContext) {
        guard logLength != 0 else {
            print("Log length is zero, cannot calculate percent deflection.")
            return
        }
        
        let spanDifference = abs(spanGround - spanMidSpan) / 2.2
        let towerRatio = (towerHeight / logLength) / 2.2
        percentDeflection = spanDifference + towerRatio
        
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            print("Failed to save context after calculating percent deflection: \(error)")
        }
    }
    
    // This function is used to calculate the deflection from the anchor side
    public func calculateAnchorDeflection(context: NSManagedObjectContext) {
        guard logLengthAnchor != 0 else {
            print("Log length is zero, cannot calculate percent deflection.")
            return
        }
        
        let difference = abs(slopeToTower - slopeToMid) / 2.2
        let divison = difference / logLengthAnchor
        
        percentDeflectionAnchor = divison * 100
        
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            print("Failed to save context after calculating percent deflection: \(error)")
        }
    }
    
    //Cable Tension = (Length M * Load KG) / (4 * deflection in M) + (weight per unit length kg * Length m ^2) / (8 * deflection in M)
    
    public func calculateMidSpanDeflection(context: NSManagedObjectContext, deflection: Double, length: Double) {
        guard deflection != 0 || length != 0 else {
            print("Log length is zero, cannot calculate percent deflection.")
            return
        }
        
        midSpanDeflection = (deflection / 100) * length
    }
    
    public func calculateTension(context: NSManagedObjectContext, deflectionType: Bool) {
        guard logLengthAnchor != 0 || logLength != 0 else {
            print("Log length is zero, cannot calculate percent deflection.")
            return
        }
        
        var totalLength: Double
        
        if(deflectionType == true){
            totalLength = logLength
        }else{
            totalLength = logLengthAnchor
        }
        
        
        let lengthLoad = totalLength * totalLoad
        let loadDeflection = lengthLoad / (4 * midSpanDeflection)
        
        let weightPerUnitLength = cableWeight * pow(totalLength, 2)
        let weightDeflection = weightPerUnitLength / (8 * midSpanDeflection)
        
        tension = (loadDeflection + weightDeflection)
        
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            print("Failed to save context after calculating percent deflection: \(error)")
        }
    }
}

extension DeflectionLogEntity {
    var isDataValidYarder: Bool {
        // Check if required fields are filled (example with `spanGround` and `towerHeight`)
        return logLength > 0 && percentDeflection > 0 && spanGround > 0 && towerHeight > 0
    }
    var isDataValidAnchor: Bool {
        // Check if required fields are filled (example with `spanGround` and `towerHeight`)
        return logLengthAnchor > 0 && percentDeflectionAnchor > 0 && slopeToTower > 0 && slopeToMid > 0
    }
}

