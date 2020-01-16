//
//  DayClass+CoreDataProperties.swift
//  reworked
//
//  Created by admin on 15/01/2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//
//

import Foundation
import CoreData


extension DayClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayClass> {
        return NSFetchRequest<DayClass>(entityName: "DayClass")
    }
    @NSManaged public var dateAsDate: Date
    @NSManaged public var date: String
    @NSManaged public var metroRide: Int
    @NSManaged public var tatRide: Int
    @NSManaged public var metroCost: Int
    @NSManaged public var tatCost: Int
    
}
