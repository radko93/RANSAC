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
    
    func DistanceByLocation(other:ValuablePoint) -> Double
    {
        let xs:Double = x - other.x;
        let ys:Double = y - other.y;
        return xs*xs + ys*ys
    }
    
    func DistanceByFeatures(other:ValuablePoint) -> Int
    {
        var sum:Int=0
        for index in 0...properties.count-1
        {
            var distance=properties[index] - other.properties[index]
            sum+=distance*distance
        }
        return sum
    }
    
    func Transform(matrix:Matrix<Double>) -> ValuablePoint
    {
        let result=mul(matrix, transpose(Matrix([[x,y,1]])))
        return ValuablePoint(x:result[0,0],y:result[1,0],properties: [])
    }
    
    
}
