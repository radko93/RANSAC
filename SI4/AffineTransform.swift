//
//  AffineTransform.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 14.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation

class AffineTransform: Transform
{
    var ElementsCount:Int
    required init(elementsCount:Int)
    {
        self.ElementsCount=elementsCount
    }
    func Transform(pairs:[Pair]) -> Matrix<Double>
    {
        var x=[Double](count: ElementsCount, repeatedValue: 0)
        var y=[Double](count: ElementsCount, repeatedValue: 0)
        var u=[Double](count: ElementsCount, repeatedValue: 0)
        var v=[Double](count: ElementsCount, repeatedValue: 0)
        
        for index in 0...ElementsCount-1
        {
            x[index]=pairs[index].First.x
            y[index]=pairs[index].First.y
            u[index]=pairs[index].Second.x
            v[index]=pairs[index].Second.y
        }
        
        let vector=transpose(Matrix([[u[0],u[1],u[2],v[0],v[1],v[2]]]))
        let matrix=Matrix([
            [x[0], y[0], 1, 0, 0, 0],
            [x[1], y[1], 1, 0, 0, 0],
            [x[2], y[2], 1, 0, 0, 0],
            [0, 0, 0, x[0], y[0], 1],
            [0, 0, 0, x[1], y[1], 1],
            [0, 0, 0, x[2], y[2], 1]
            ])
        
        let resultVector=mul(inv(matrix),vector)
        return Matrix([[resultVector[0, 0], resultVector[1, 0], resultVector[2, 0]],[resultVector[3, 0], resultVector[4, 0], resultVector[5, 0]],[0, 0, 1]])
    }
}