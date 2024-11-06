//
//  DeflectionLogEntity+CoreDataProperties.swift
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
    @NSManaged public var length: Double
    @NSManaged public var logDate: Date?
    @NSManaged public var logDescription: String?
    @NSManaged public var logName: String?
    @NSManaged public var northCoord: Double
    @NSManaged public var percentDeflection: Double
    @NSManaged public var southCoord: Double
    @NSManaged public var spanGround: Double
    @NSManaged public var spanMidSpan: Double
    @NSManaged public var towerHeight: Double
    @NSManaged public var westCoord: Double
    @NSManaged public var yarderOrAnchor: String?

}

extension DeflectionLogEntity : Identifiable {

}
