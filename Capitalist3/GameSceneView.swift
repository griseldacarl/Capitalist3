//
//  GameSceneView.swift
//  capitalist
//
//  Created by Carl Mitchell on 7/30/15.
//  Copyright (c) 2015 Carl Mitchell. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class GameSceneView: SKScene {
 
    let infocard: InfoCardView=InfoCardView()
    let stock: StockView = StockView()
    let infoCardButtonLabel : SKLabelNode =  SKLabelNode(text: "Info Card")
    let stockButtonLabel : SKLabelNode =  SKLabelNode(text: "Stock")
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.infocard.alpha = CGFloat(0)
        self.stock.alpha = CGFloat(0)
        
        //Create the Buttons that will show and hide the different cards for the game
        infoCardButtonLabel.fontColor = UIColor.whiteColor()
        infoCardButtonLabel.fontName = "Chalkduster"
        infoCardButtonLabel.fontSize = 16
        infoCardButtonLabel.position = CGPointMake(50, 50 )
        
        stockButtonLabel.fontColor = UIColor.whiteColor()
        stockButtonLabel.fontName = "Chalkduster"
        stockButtonLabel.fontSize = 16
        stockButtonLabel.position = CGPointMake(150, 50 )
        
        self.userInteractionEnabled = true
        self.addChild(infocard)
        self.addChild(stock)
        self.addChild(infoCardButtonLabel)
        self.addChild(stockButtonLabel)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateView", name: "GameSceneModelAndSequencer", object: nil)
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch!.locationInNode(self)
      
        
        
        if self.infoCardButtonLabel.containsPoint(location){
           self.infocard.alpha = CGFloat(1)
           self.stock.alpha = CGFloat(0)
           self.infoCardButtonLabel.alpha = CGFloat(0)
           self.stockButtonLabel.alpha = CGFloat(0)
           println("Info Card was click!")
           
        }
        
        if self.stockButtonLabel.containsPoint(location){
            self.infocard.alpha = CGFloat(0)
            self.stock.alpha = CGFloat(1)
            self.infoCardButtonLabel.alpha = CGFloat(0)
            self.stockButtonLabel.alpha = CGFloat(0)
            println("Stock was click!")
            
        }
        
    }
    
     func updateView(){
      println ("GameSceneView was updated!")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
