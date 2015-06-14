//
//  ViewController.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 13.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var image=Image(name: "1a.png")
        print("\(image.ValuablePoints.last?.properties[0])")
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

