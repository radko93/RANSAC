//
//  RandomSelector.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 14.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation

class RandomSelector : Selector
{
    func TakeRandom(pairs: [Pair], count: Int) -> [Pair] {
        return pairs.choose(count)
    }
    
    
}