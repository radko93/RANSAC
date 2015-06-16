//
//  NeighboursAnalysis.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 15.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation


class NeighboursAnalysis
{
    
    
    static func FeatureDistances(points1:[ValuablePoint],points2:[ValuablePoint]) -> [[Int]]
    {
        var distances=[[Int]](count:points1.count, repeatedValue:[Int](count:points2.count, repeatedValue:0)) //Array2D(cols: points1.count,rows: points2.count)
        let onEight=points1.count/4
        
        
        for p1 in 0...points1.count-1
        {
            for p2 in 0...points2.count-1
            {
                distances[p1][p2]=points1[p1].DistanceByFeatures(points2[p2])
            }
        }
        
        
        
        return distances
    }
    
    
    static func FeatureDistancesPart(points1:[ValuablePoint],points2:[ValuablePoint],var distances:[[Int]], startIndex:Int, endIndex:Int)
    {
        dispatch_sync(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), {
            
            for p1 in startIndex...endIndex-1
            {
                for p2 in 0...points2.count-1
                {
                    distances[p1][p2]=points1[p1].DistanceByFeatures(points2[p2])
                }
            }
        })
    }
    
    static func MututalNeighbours(points1:[ValuablePoint],points2:[ValuablePoint]) -> [Pair]
    {
        return MutualNeighbours(FeatureDistances(points1, points2: points2), points1: points1, points2: points2)
    }
    
    static func MutualNeighbours(distances:[[Int]],points1:[ValuablePoint],points2:[ValuablePoint]) -> [Pair]
    {
        return MutualNeighboursPart(distances, points1: points1, points2: points2, startIndex:  0, endIndex: points1.count)
    }
    
    static func MutualNeighboursPart(distances:[[Int]],points1:[ValuablePoint],points2:[ValuablePoint],startIndex:Int,endIndex:Int) -> [Pair]
    {
        var mutualNeighbours=[Pair]()
        
        for index in startIndex...endIndex-1
        {
            var minDistance = distances[index][0]
            for p2 in 1...points2.count-1
            {
                var distance=distances[index][p2]
                if distance < minDistance
                {
                    minDistance = distance
                }
            }
            for p3 in 0...points2.count-1
            {
                
                if distances[index][p3] == minDistance
                {
                    println("true  \(distances[index][p3]) \(minDistance) \(index) \(p3)")
                    var closest=true
                    for var p=0; closest && p<points1.count; p++
                    {
                        if distances[p][p3] < minDistance
                        {
                            closest = false
                        }
                        
                    }
                    if closest
                    {
                        mutualNeighbours.append(Pair(first: points1[index],second: points2[p3]))
                    }
                    
                }
            }
            
            
        }
        return mutualNeighbours
    }
    
    
    
    static func CompactNeighbours(neighbours:[Pair], closestPointsCount:Int, compactThresold:Double) -> [Pair]
    {
        let halfOfLenght=neighbours.count/2
        var part1 = [Pair]()
        var part2 = [Pair]()
        
        dispatch_sync(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), {
            part1 = self.compactNeighboursPart(neighbours, closestPointsCount: closestPointsCount, compactThresold: compactThresold, startIndex: 0, endIndex: halfOfLenght)
        })
        dispatch_sync(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), {
            part2 = self.compactNeighboursPart(neighbours, closestPointsCount: closestPointsCount, compactThresold: compactThresold, startIndex: halfOfLenght, endIndex: neighbours.count)
        })
        
        let result = part1.union(part2)
        return result
        
    }
    
    
    
    static func compactNeighboursPart(neighbours:[Pair], closestPointsCount:Int, compactThresold:Double, startIndex:Int, endIndex:Int) -> [Pair]
    {
        var compactNeighbours=[Pair]()
        
        for index in startIndex...endIndex-1
        {
            let pair=neighbours[index]
            let tempOne=neighbours.filter({$0.First/=pair.First})
            var resultOne=tempOne.map {
                (element:Pair) -> (Pair,Double) in
                let returnTuple:(Pair,Double)=(element,element.First.DistanceByLocation(pair.First))
                return returnTuple
            }
            resultOne.sort({
                (element:(Pair,Double), other:(Pair,Double)) -> Bool in
                return element.1 > other.1
            })
            let distanceOne = Array(Set(resultOne.map({$0.1})))[closestPointsCount]
            let closestToFirst = resultOne.filter({$0.1 < distanceOne}).map({$0.0})
            
            let tempTwo=neighbours.filter({$0.Second/=pair.Second})
            var resultTwo=tempTwo.map {
                (element:Pair) -> (Pair,Double) in
                let returnTuple:(Pair,Double)=(element,element.Second.DistanceByLocation(pair.Second))
                return returnTuple
            }
            resultTwo.sort({
                (element:(Pair,Double), other:(Pair,Double)) -> Bool in
                return element.1 > other.1
            })
            let distanceTwo = Array(Set(resultTwo.map({$0.1})))[closestPointsCount]
            let closestToSecond = resultOne.filter({$0.1 < distanceTwo}).map({$0.0})
            
            
            if  Double(closestToFirst.intersection(closestToSecond).count) > ((Double(closestToFirst.union(closestToSecond).count)) * compactThresold)
            {
                compactNeighbours.append(pair)
            }
            
        }
        return compactNeighbours
    }
    
    
    
    
}