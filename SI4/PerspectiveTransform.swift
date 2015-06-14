//
//  PerspectiveTransform.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 14.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation

class PerspectiveTransform: Transform
{
    var ElementsCount:Int
    required init(elementsCount:Int)
    {
        self.ElementsCount=elementsCount
    }
    func Transform(pairs:[Pair]) -> Matrix<Double>
    {
        var x=[Double]()
        var y=[Double]()
        var u=[Double]()
        var v=[Double]()
        
        for index in 0...ElementsCount
        {
            x[index]=pairs[index].First.x
            y[index]=pairs[index].First.y
            u[index]=pairs[index].Second.x
            v[index]=pairs[index].Second.y
        }
        
        let vector=transpose(Matrix([[u[0],u[1],u[2],v[0],v[1],v[2]]]))
        let matrixArray=[
            [x[0], y[0], 1, 0, 0, 0, -u[0]*x[0], -u[0]*y[0]],
            [x[1], y[1], 1, 0, 0, 0, -u[1]*x[1], -u[1]*y[1]],
            [x[2], y[2], 1, 0, 0, 0, -u[2]*x[2], -u[2]*y[2]],
            [x[3], y[3], 1, 0, 0, 0, -u[3]*x[3], -u[3]*y[3]],
            [0, 0, 0, x[0], y[0], 1, -v[0]*x[0], -v[0]*y[0]],
            [0, 0, 0, x[1], y[1], 1, -v[1]*x[1], -v[1]*y[1]],
            [0, 0, 0, x[2], y[2], 1, -v[2]*x[2], -v[2]*y[2]],
            [0, 0, 0, x[3], y[3], 1, -v[3]*x[3], -v[3]*y[3]]
            ]
        let matrix=Matrix(matrixArray)
        
        let resultVector=mul(inv(matrix),vector)
        return Matrix([[resultVector[0, 0], resultVector[1, 0], resultVector[2, 0]],[resultVector[3, 0], resultVector[4, 0], resultVector[5, 0]],[resultVector[6, 0], resultVector[7, 0], 1]])
    }
}