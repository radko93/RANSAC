//
//  Matrix2D.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 14.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Foundation
struct Matrix2D<T> {
    
    var _storage:[[T?]] = []
    
    subscript(x:Int, y:Int) -> T? {
        get {
            if _storage.count <= x {
                return nil
            }
            if _storage[x].count <= y {
                return nil
            }
            return _storage[x][y]
        }
        set(val) {
            if _storage.count <= x {
                let cols = [[T?]](count: x - _storage.count + 1, repeatedValue: [])
                _storage.extend(cols)
            }
            if _storage[x].count <= y {
                let rows = [T?](count: y - _storage[x].count + 1, repeatedValue: nil)
                _storage[x].extend(rows)
            }
            _storage[x][y] = val
        }
    }
}