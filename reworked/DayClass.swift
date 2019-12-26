//
//  DayClass.swift
//  reworked
//
//  Created by Дмитрий on 24.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

import Foundation

class DayClass: Decodable {
    
    var date: String = ""
    var metroRide: Int = 0
    var tatRide: Int = 0

    let metroCost: Int = 38
    let tatCost: Int = 38
}
