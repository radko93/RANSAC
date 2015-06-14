//
//  ValuablePoint.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 13.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation

class ValuablePoint : Point, Equatable
{
    let properties:[Int]
    var closestNeighbour:ValuablePoint?
    init(x: Double, y: Double, properties:[Int])
    {
        self.properties=properties
        super.init(x: x, y: y)
    }
    
    func DistanceByLocation(other:Point) -> Double
    {
        let xs:Double = x - other.x;
        let ys:Double = y - other.y;
        return xs*xs + ys*ys
    }
}

func ==(lhs: ValuablePoint, rhs: ValuablePoint) -> Bool {
    return lhs.x==rhs.x && lhs.y==rhs.y
}