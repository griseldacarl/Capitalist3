//
//  InfoCardView.swift
//  capitalist
//
//  Created by Carl Mitchell on 8/2/15.
//  Copyright (c) 2015 Carl Mitchell. All rights reserved.
//

import UIKit
import SpriteKit

class InfoCardView: SKShapeNode {
   
    override init(){
       super.init()
        
        var rect = CGRect(origin: CGPointMake(0, 0), size: CGSize(width: 640, height: 480))
       
        self.position = CGPointMake(100, 100)
        self.path = CGPathCreateWithRect(rect, nil)
        
        //Border and Basic Frame
        self.lineWidth = 1
        self.strokeColor = UIColor.whiteColor()
        self.fillColor = UIColor.blackColor()
        
        
        //Title: Acquire and Title: Reference Chart
        let titleAcquire : SKLabelNode = SKLabelNode(text: "ACQUIRE")
         titleAcquire.fontColor = UIColor.whiteColor()
         titleAcquire.fontName = "Chalkduster"
         titleAcquire.fontSize = 36
         titleAcquire.position = CGPointMake(100, rect.size.height-40)
        
        let titleReference : SKLabelNode = SKLabelNode (text: "REFERENCE CHART")
         titleReference.fontColor = UIColor.whiteColor()
         titleReference.fontName="Chalkduster"
         titleReference.fontSize = 24
         titleReference.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        
    
        self.addChild(titleAcquire)
        self.addChild(titleReference)
    }


    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch?.locationInNode(self)
        
       
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
