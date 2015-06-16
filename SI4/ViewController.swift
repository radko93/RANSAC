//
//  ViewController.swift
//  SI4
//
//  Created by Radoslaw Czemerys on 13.06.2015.
//  Copyright (c) 2015 radko93. All rights reserved.
//

import Cocoa
import QuartzCore

class ViewController: NSViewController {
    
    
    @IBOutlet weak var imagepng1: NSImageView!
    @IBOutlet weak var imagepng2: NSImageView!
    
    @IBOutlet var views: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                let image1=Image(name: "img3.png")
                let image2=Image(name: "img4.png")
                let mutualNeighbours=NeighboursAnalysis.MututalNeighbours(image1.ValuablePoints, points2: image2.ValuablePoints)
        //        println(mutualNeighbours.count)
        //        let result = Ransac.BestModel(mutualNeighbours, transform: AffineTransform(elementsCount: 3), selector: RandomSelector(), iterationsNumber: 100, maxError: 10)
        //        println(result.1)
                let result2 = NeighboursAnalysis.CompactNeighbours(mutualNeighbours, closestPointsCount: 2, compactThresold: 0.5)
        //        println(result2.count)
        drawImages("img3", name2: "img4")
        for element in result2
        {
            drawLineFrom(element.First, toPoint: element.Second)
        }
   
    }
 
    func drawLineFrom(fromPoint: Point, toPoint: Point) {
        
        var lineShape = CAShapeLayer()
        var linePath:CGMutablePathRef = CGPathCreateMutable()
        
        
        lineShape.lineWidth = 4.0;
        lineShape.lineCap = kCALineCapRound;
        lineShape.strokeColor = CGColorCreate(CGColorSpaceCreateDeviceGray(), [CGFloat(0.0), CGFloat(1.0)])
        CGPathMoveToPoint(linePath, nil, fromPoint.x.f as CGFloat, fromPoint.y.f as CGFloat);
        CGPathAddLineToPoint(linePath, nil, toPoint.x.f+600 as CGFloat, toPoint.y.f as CGFloat);
        
        lineShape.path = linePath;
        self.view.layer!.addSublayer(lineShape)
    }
    
    private func drawImages(name1:String,name2:String)
    {
        
        let fileURL = NSBundle.mainBundle().URLForResource(name1, withExtension: "png")
        let fileURL2 = NSBundle.mainBundle().URLForResource(name2, withExtension: "png")
        
        let beginImage = CIImage(contentsOfURL: fileURL)
        let beginImage2 = CIImage(contentsOfURL: fileURL2)
        let context = CIContext()
        let filter = CIFilter(name: "CISepiaTone")
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        filter.setValue(0, forKey: kCIInputIntensityKey)
        let context2 = CIContext()
        let filter2 = CIFilter(name: "CISepiaTone")
        filter2.setValue(beginImage2, forKey: kCIInputImageKey)
        filter2.setValue(0, forKey: kCIInputIntensityKey)
        let cgimg = context.createCGImage(filter.outputImage,fromRect: filter.outputImage.extent())
        let cgimg2 = context2.createCGImage(filter2.outputImage,fromRect: filter2.outputImage.extent())
        
        let newImage = NSImage(CGImage: cgimg, size: NSSize(width: 800, height: 600))
        let newImage2 = NSImage(CGImage: cgimg2, size: NSSize(width: 800, height: 600))
        imagepng1.image = newImage
        imagepng2.image = newImage2
        
    }
    
    override var representedObject: AnyObject? {
        didSet {
            
        }
    }
    
    
    
}

