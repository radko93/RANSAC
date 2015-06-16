//
//  Pair.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 13.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation
struct Pair : Equatable
{
    let First:ValuablePoint
    let Second:ValuablePoint
    
    init(first:ValuablePoint,second:ValuablePoint)
    {
        self.First=first
        self.Second=second
    }
}
func ==(lhs: Pair, rhs: Pair) -> Bool
{
    return lhs.First == rhs.First && lhs.Second==rhs.Second
}