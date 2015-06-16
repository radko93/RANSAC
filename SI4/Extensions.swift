//
//  Extensions.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 14.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation


extension Int {
    func random() -> Int {
        return Int(arc4random_uniform(UInt32(abs(self))))
    }
    func indexRandom() -> [Int] {
        var newIndex = 0
        var shuffledIndex:[Int] = []
        while shuffledIndex.count < self {
            newIndex = Int(arc4random_uniform(UInt32(self)))
            if !(find(shuffledIndex,newIndex) > -1 ) {
                shuffledIndex.append(newIndex)
            }
        }
        return  shuffledIndex
    }
}
extension Array {
    
    
    func chooseOne() -> T {
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
    func choose(x:Int) -> [T] {
        var shuffledContent:[T] = []
        let shuffledIndex:[Int] = x.indexRandom()
        for i in 0...shuffledIndex.count-1 {
            shuffledContent.append(self[shuffledIndex[i]])
        }
        return shuffledContent }
    
    func unique <T: Equatable> () -> [T] {
        var result = [T]()
        
        for item in self {
            if !result.contains(item as! T) {
                result.append(item as! T)
            }
        }
        
        return result
    }
    func each (call: (Element) -> ()) {
        
        for item in self {
            call(item)
        }
        
    }
    func union <U: Equatable> (values: [U]...) -> Array {
        
        var result = self
        
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value as! Element)
                }
            }
        }
        
        return result
        
    }
    func all (test: (Element) -> Bool) -> Bool {
        for item in self {
            if !test(item) {
                return false
            }
        }
        
        return true
    }
    func indexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            return Swift.find(unsafeBitCast(self, [U].self), item)
        }
        
        return nil
    }
    func contains <T: Equatable> (items: T...) -> Bool {
        return items.all { self.indexOf($0) >= 0 }
    }
    
    func intersection <T: Equatable> (values: [T]...) -> Array {
        
        var result = self
        var intersection = Array()
        
        for (i, value) in enumerate(values) {
            if (i > 0) {
                result = intersection
                intersection = Array()
            }
            value.each { (item: T) -> Void in
                if result.contains(item) {
                    intersection.append(item as! Element)
                }
            }
            
        }
        
        return intersection
        
    }
}

