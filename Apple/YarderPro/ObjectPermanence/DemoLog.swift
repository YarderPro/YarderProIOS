//
//  DemoLog.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/20/24.
//

/*
import Foundation
import CoreData

// A mock NSManagedObject to simulate DeflectionLogEntity for preview
class PreviewDeflectionLogEntity: NSManagedObject {
    @objc var logName: String?
    @objc var logDate: Date?
    @objc var logDescription: String?
    @objc var southCoord: Double = 0.0
    @objc var northCoord: Double = 0.0
    @objc var eastCoord: Double = 0.0
    @objc var westCoord: Double = 0.0
    @objc var spanGround: Double = 0.0
    @objc var spanMidSpan: Double = 0.0
    @objc var percentDeflection: Double = 0.0
    @objc var towerHeight: Double = 0.0
    @objc var logLength: Double = 0.0
    @objc var yarderOrAnchor: String?

    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}

// A mock context for preview purposes
class PreviewDeflectionLogWrapper: DeflectionLogWrapper {
    init() {
        let entityDescription = NSEntityDescription()
        let logEntity = DeflectionLogEntity(entity: entityDescription, insertInto: nil)
        logEntity.logName = "Demo Log"
        logEntity.logDate = Date()
        logEntity.logDescription = "This is a demo deflection log for preview purposes."
        logEntity.southCoord = 12.0
        logEntity.northCoord = 34.0
        logEntity.eastCoord = 56.0
        logEntity.westCoord = 78.0
        logEntity.spanGround = 100.0
        logEntity.spanMidSpan = 50.0
        logEntity.towerHeight = 30.0
        logEntity.logLength = 200.0
        logEntity.yarderOrAnchor = YarderOrAnchor.yarder.rawValue

        // A mock context
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        super.init(logEntity: logEntity, context: context)
    }
}
*/
