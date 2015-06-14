//
//  ValuablePoint.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 13.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation

class ValuablePoint : Point
{
    let properties:[Int]
    var closestNeighbour:ValuablePoint?
    init(x: Double, y: Double, properties:[Int])
    {
        self.properties=properties
        super.init(x: x, y: y)
      
    }
    
    func toString()-> String
    {
        return " "
    }
}