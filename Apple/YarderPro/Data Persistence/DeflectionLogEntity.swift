//
//  DeflectionLogEntity.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/18/24.
//
//

import Foundation
import CoreData

/*
 DESCRIPTION:
 This is the core file for  the deflection log entity class, creating MSManaged variables. As an extension of the class, it provides the necissary declarations of variables and functions. Within the class, variables are catagorized acording to use within the application. While reading this file, look at the YarderPro data modeled file 'YarderPro.xcdatamodeld' to better understand what the MSManaged variables are refrencing. These functions include calculation
 */

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
    @NSManaged public var slopeToAnchor: Double
    @NSManaged public var slopeMidSpan: Double
    @NSManaged public var towerHeight: Double
    @NSManaged public var spanLength: Double
    @NSManaged public var percentDeflectionYarderSide: Double
    
    //Values used to calculate deflection on the anchor side
    @NSManaged public var slopeToTower: Double
    @NSManaged public var slopeToMidSpanAnchor: Double
    @NSManaged public var spanLengthAnchor: Double
    @NSManaged public var percentDeflectionAnchor: Double
    
    //Values used to calculate Tension
    @NSManaged public var tension: Double
    @NSManaged public var cableWeight: Double
    @NSManaged public var totalLoad: Double
    @NSManaged public var midSpanDeflectionMeters: Double
    
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
    public func calculateYarderDeflection(context: NSManagedObjectContext) {
        guard spanLength != 0 else {
            print("Log length is zero, cannot calculate percent deflection.")
            return
        }
        
        let spanDifference = abs(slopeToAnchor - slopeMidSpan) / 2.2
        let towerRatio = (towerHeight / spanLength) / 2.2
        percentDeflectionYarderSide = spanDifference + towerRatio
        
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
        guard spanLengthAnchor != 0 else {
            print("Log length is zero, cannot calculate percent deflection.")
            return
        }
        // (abs(slopeToTower - slopeToMidPoint) /2.2) / length From Yarder to anchor
        let slope = abs(slopeToTower - slopeToMidSpanAnchor)
        let ftDeflection = (slope * spanLengthAnchor)/2
        
        percentDeflectionAnchor = ftDeflection / spanLengthAnchor
        
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
        
        midSpanDeflectionMeters = (deflection / 100) * length
    }
    
    public func calculateTension(context: NSManagedObjectContext, deflectionType: Bool) {
        guard spanLengthAnchor != 0 || spanLength != 0 else {
            print("Log length is zero, cannot calculate percent deflection.")
            return
        }
        
        var totalLength: Double
        
        if(deflectionType == true){
            totalLength = spanLength
        }else{
            totalLength = spanLengthAnchor
        }
        
        
        let lengthLoad = totalLength * totalLoad
        let loadDeflection = lengthLoad / (4 * midSpanDeflectionMeters)
        
        let weightPerUnitLength = cableWeight * pow(totalLength, 2)
        let weightDeflection = weightPerUnitLength / (8 * midSpanDeflectionMeters)
        
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
        return spanLength > 0 && slopeMidSpan > 0 && slopeToAnchor > 0 && towerHeight > 0 && slopeToAnchor < 90 && slopeMidSpan < 90 && percentDeflectionYarderSide > 0
    }
    var isDataValidAnchor: Bool {
        // Check if required fields are filled (example with `spanGround` and `towerHeight`)
        return spanLengthAnchor > 0 && percentDeflectionAnchor > 0 && slopeToTower > 0 && slopeToMidSpanAnchor > 0 && slopeToMidSpanAnchor < 90 && slopeToTower < 90
    }
}

