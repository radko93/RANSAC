//
//  DistanceHeuristic.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 14.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation

class DistanceHeuristic : Selector
{
    
    var r:Double
    var R:Double
    
    init(width:Int, height:Int,minRadius:Double, maxRadius:Double)
    {
        r=(Double(width)*minRadius)*(Double(width)*minRadius)
        R=(Double(height)*maxRadius)*(Double(width)*minRadius)
    }
    func TakeRandom(pairs: [Pair], count: Int) -> [Pair] {
        var result=[Pair]()
        
        result[0]=pairs.chooseOne()
        
        func indexCalc(x:Int) -> Int {
            return ((x-1)/2)*2
        }
        
        for index in 0...count
        {
            var random:Pair
            var distanceFirst:Double
            var distanceSecond:Double
            
            do
            {
            do {
                random=pairs.chooseOne()
            } while contains(pairs, random)
            distanceFirst=result[indexCalc(index)].First.DistanceByLocation(random.First)
            distanceSecond=result[indexCalc(index)].Second.DistanceByLocation(random.Second)
            } while distanceFirst > R || distanceSecond > R || distanceFirst < r || distanceSecond < r
            result[index] = random;
            
        }
        return result
    }
    
}