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

    @NSManaged public var eastCoord: Double
    @NSManaged public var westCoord: Double
    @NSManaged public var southCoord: Double
    @NSManaged public var northCoord: Double
    
    @NSManaged public var spanGround: Double
    @NSManaged public var spanMidSpan: Double
    @NSManaged public var towerHeight: Double
    @NSManaged public var logLength: Double
    
    @NSManaged public var id: UUID
  
    
    @NSManaged public var logDate: Date
    @NSManaged public var logDescription: String?
    @NSManaged public var logName: String?
    @NSManaged public var percentDeflection: Double
    
    public enum YarderType: String {
        case yarder
        case anchor
    }

    @NSManaged public var yarderOrAnchor: String?

    public var yarderType: YarderType {
        get {
            YarderType(rawValue: yarderOrAnchor ?? "") ?? .yarder // Default to `.yarder` if nil
        }
        set {
            yarderOrAnchor = newValue.rawValue
        }
    }
    
    public func calculatePercentDeflection(context: NSManagedObjectContext) {
        guard logLength != 0 else {
            print("Log length is zero, cannot calculate percent deflection.")
            return
        }
        
        let spanDifference = abs(spanGround - spanMidSpan) / 2.2
        let towerRatio = (towerHeight / logLength) / 2.2 * 100
        percentDeflection = spanDifference + towerRatio
        
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
    var isDataValid: Bool {
        // Check if required fields are filled (example with `spanGround` and `towerHeight`)
        return spanGround > 0 && towerHeight > 0
    }
}

