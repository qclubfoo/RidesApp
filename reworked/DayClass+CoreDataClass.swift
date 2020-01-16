//
//  DayClass+CoreDataClass.swift
//  reworked
//
//  Created by admin on 15/01/2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//
//

import Foundation
import CoreData

@objc(DayClass)
public class DayClass: NSManagedObject {
    
    convenience init(insertInto context: NSManagedObjectContext, entity: NSEntityDescription, data: (date: String, metroRides: Int, tatRides: Int)) {
        self.init(entity: entity, insertInto: context)
        date = data.date
        metroRide = data.metroRides
        tatRide = data.tatRides
        tatCost = 38
        metroCost = 38
    }

}
