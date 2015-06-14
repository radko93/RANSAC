//
//  Transform.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 14.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation

protocol Transform
{
    var ElementsCount:Int { get}
    init(elementsCount:Int)
    func Transform(pairs:[Pair]) -> Matrix<Double>

}