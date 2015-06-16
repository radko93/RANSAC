//
//  Ransac.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 16.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation

class Ransac {
    
    
    
    static func BestModel(neighbours:[Pair], transform:Transform, selector:Selector, iterationsNumber:Int, maxError:Double) -> (Matrix<Double>, Double)
    {
        var bestModel:Matrix<Double>?
        var bestScore:Double
        
        do
        {
            bestScore = 0
            for index in 0...iterationsNumber
            {
                var model:Matrix<Double>?
                do
                {
                    var s = selector.TakeRandom(neighbours, count: transform.ElementsCount)
                    model = transform.Transform(s)
                } while model == nil
                
                var score = 0
                for pair in neighbours
                {
                    var error = modelError(model!, pair: pair)
                    if error < maxError
                    {
                        score++
                    }
                }
                if Double(score) > bestScore
                {
                    bestScore=Double(score)
                    bestModel=model
                }
            }
        } while (bestModel == nil)
        return (bestModel!,bestScore)
    }
    
    private static func modelError(matrix:Matrix<Double>,pair:Pair) -> Double
    {
        return pair.First.Transform(matrix).DistanceByLocation(pair.Second)
    }
}