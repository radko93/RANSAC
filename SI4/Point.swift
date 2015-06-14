//
//  Point.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 13.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation

class Point : Equatable
{
    var x:Double
    var y:Double
    init(x:Double,y:Double)
    {
        self.x=x
        self.y=y
    }
    
    
}
func ==(lhs: Point, rhs: Point) -> Bool {
    return lhs.x==rhs.x && lhs.y==rhs.y 
}