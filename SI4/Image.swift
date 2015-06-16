//
//  FileParser.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 13.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation
class Image  {
    var numberOfParameters:Int
    var numberOfPairs:Int
    let name:String
    var ValuablePoints:[ValuablePoint]
    
    init(name:String)
    {
        self.name=name
        self.ValuablePoints=[]
        numberOfPairs=0
        numberOfParameters=0
        parseFile()
    }
    
    
    func parseFile()
    {
        
        let path = NSBundle.mainBundle().pathForResource(name, ofType: ".haraff.sift")
        var err: NSError? = NSError()
        var counter=0
        
        if let aStreamReader = StreamReader(path: path!) {
            while let line = aStreamReader.nextLine() {
                if counter==0
                {
                    numberOfParameters=parseStringtoInt(line)
                    counter++
                }
                else if counter == 1
                {
                    numberOfPairs=parseStringtoInt(line)
                    counter++
                }
                else
                {
                    let paramsarray = split(line) {$0 == " "}
                    var params:[Int]=[]
                    
                    for index in 5...paramsarray.count-1
                    {
                        params.append(parseStringtoInt(paramsarray[index]))
                    }
                    ValuablePoints.append(ValuablePoint(x: parseStringtoDouble(paramsarray[0]),y: parseStringtoDouble(paramsarray[1]),properties: params))
                }
                
            }
            
            
            aStreamReader.close()
        }
    }
    func parseStringtoInt(name:String) -> Int
    {
        return (name as NSString).integerValue as Int
    }
    func parseStringtoDouble(name:String) -> Double
    {
        return (name as NSString).doubleValue as Double
    }
    
}