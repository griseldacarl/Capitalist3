//
//  GameViewController.swift
//  capitalist
//
//  Created by Carl Mitchell on 7/20/15.
//  Copyright (c) 2015 Carl Mitchell. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit


class GameViewController: UIViewController {
    
    var overlaySceneWelcome: WelcomeScreenAquireView!
    var overlaySceneClose: CloseSceneView!
    var overlaySceneGame: GameSceneView!
    var overlaySceneTileManagerPlayer: TileManagerPlayerView!
    var gameBoard: SCNScene!
    
    
    let modelGameScene = GameSceneModelAndSequencer()
    let PlayersToBe3 = 3
    let PlayersToBe4 = 4
    let PlayersToBe5 = 5
    let PlayersToBe6 = 6
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        self.gameBoard = SCNScene(named: "gameboard.scnassets/gameboard.dae")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        self.gameBoard.rootNode.addChildNode(cameraNode)
        
        
        //        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 1, z: 7)
        //
        // create and add a light to the scene
        let lightRightNode = SCNNode()
        lightRightNode.light = SCNLight()
        lightRightNode.light!.type = SCNLightTypeOmni
        lightRightNode.position = SCNVector3(x: 30, y: 30, z: 100)
        self.gameBoard.rootNode.addChildNode(lightRightNode)
        
        let lightLeftNode = SCNNode()
        lightLeftNode.light = SCNLight()
        lightLeftNode.light!.type = SCNLightTypeOmni
        lightLeftNode.position = SCNVector3(x: -20, y: 30, z: 100)
        self.gameBoard.rootNode.addChildNode(lightLeftNode)
        
        let lightRightBottomNode = SCNNode()
        lightRightBottomNode.light = SCNLight()
        lightRightBottomNode.light!.type = SCNLightTypeOmni
        lightRightBottomNode.position = SCNVector3(x: 30, y: 0, z: 100)
        self.gameBoard.rootNode.addChildNode(lightRightBottomNode)
        
        let lightLeftBottomNode = SCNNode()
        lightLeftBottomNode.light = SCNLight()
        lightLeftBottomNode.light!.type = SCNLightTypeOmni
        lightLeftBottomNode.position = SCNVector3(x: -20, y: 0, z: 100)
        self.gameBoard.rootNode.addChildNode(lightLeftBottomNode)
        
        // create and add a light to the scene
        let lightDirectionNode = SCNNode()
        lightDirectionNode.light = SCNLight()
        lightDirectionNode.light!.type = SCNLightTypeDirectional
        lightDirectionNode.orientation = SCNQuaternion(x:0,y:0,z: 20, w:5)
        self.gameBoard.rootNode.addChildNode(lightDirectionNode)
        
        
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.whiteColor()
        self.gameBoard.rootNode.addChildNode(ambientLightNode)
        
        
        
        // retrieve the ship node
        let board = self.gameBoard.rootNode.childNodeWithName("board", recursively: true)!
        
        // animate the 3d object
        board.runAction(SCNAction.rotateByX(1.58, y: 0, z: 0, duration: 1))
        board.runAction(SCNAction.rotateByX(0, y: 0, z: -1.58, duration: 1))
        //
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        scnView.autoenablesDefaultLighting  = true
        scnView.allowsCameraControl = true
        
        
        // allows the user to manipulate the camera
       // scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        //scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.blackColor()
        let scene = SCNScene()
        // set the scene to the view
        scnView.scene = scene
        
        
    }
    override func viewWillLayoutSubviews() {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        if(scnView.scene != nil){
            
            //Add the overlayScene
            self.overlaySceneWelcome  =  WelcomeScreenAquireView(size: scnView.bounds.size)
            self.overlaySceneWelcome.name="WelcomeScreenAquireView";
            
            scnView.overlaySKScene = overlaySceneWelcome
     
            self.overlaySceneWelcome.addObserver(scnView, forKeyPath: "3playerLabelclicked", options: .New, context: nil)
            
            // allows the user to manipulate the camera
            //scnView.allowsCameraControl = true
            
            // show statistics such as fps and timing information
            scnView.showsStatistics = true
        
        }
    }
    
 
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "set3Players", name: "3Players", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "set4Players", name: "4Players", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "set5Players", name: "5Players", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "set6Players", name: "6Players", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "doStart", name: "StartButton", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showInfoCardView", name: "infocardbuttonpress", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showStockView", name: "stockbuttonpress", object: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "3Players", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "4Players", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "5Players", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "6Players", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "StartButton", object: nil)
    
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "infocardbuttonpress", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "stockbuttonpress", object: nil)
        
    }
    
    func showInfoCardView (){
        let scnView = self.view as! SCNView
        scnView.scene =  SCNScene()
        if(self.overlaySceneGame != nil){
            self.overlaySceneGame.stock.hidden = true
            self.overlaySceneGame.infocard.hidden = false
        }
    }
    
    func showStockView(){
        let scnView = self.view as! SCNView
        scnView.scene =  SCNScene()
        if(self.overlaySceneGame != nil){
            self.overlaySceneGame.stock.hidden = false
            self.overlaySceneGame.infocard.hidden = true
            
        }
    }
    
    func set3Players(){
        println("Player : 3Players")
        modelGameScene.setNumberOfPlayersWithNotification(self.PlayersToBe3)
        
        var scene3Player = SKScene()
        let scnView = self.view as! SCNView
        scene3Player.scaleMode = .ResizeFill
        let threePlayerLabel : SKLabelNode = SKLabelNode(text: "Loading Three Players")
        threePlayerLabel.fontColor = UIColor.yellowColor()
        threePlayerLabel.fontSize=48
        threePlayerLabel.position = CGPointMake(scnView.bounds.size.width/2,scnView.bounds.size.height/2)
        scene3Player.addChild(threePlayerLabel)
        scnView.overlaySKScene = scene3Player
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("transitionToTileManager3PlayerViewScene"), userInfo: nil, repeats: false)
    }
    
    func transitionToTileManager3PlayerViewScene(){
        let scnView = self.view as! SCNView
        if(self.overlaySceneTileManagerPlayer != nil){
            scnView.overlaySKScene = self.overlaySceneTileManagerPlayer
        }
        else {
            self.overlaySceneTileManagerPlayer  =  TileManagerPlayerView(size: scnView.bounds.size)
            self.overlaySceneTileManagerPlayer.name="TileManagerPlayerView";
            self.overlaySceneTileManagerPlayer.addPlayers(PlayerModel(_ID: 1000,_name: "Bob",_image: ""), player2: PlayerModel(_ID: 1000,_name: "Jim",_image: ""), player3: PlayerModel(_ID: 1000,_name: "Jeff",_image: ""))
            scnView.overlaySKScene = overlaySceneTileManagerPlayer
        }
    }
    
    
    func transitionToWelcomeScene(){
       let scnView = self.view as! SCNView
        if(self.overlaySceneWelcome != nil){
           scnView.overlaySKScene = self.overlaySceneWelcome
        }
        else {
            self.overlaySceneWelcome  =  WelcomeScreenAquireView(size: scnView.bounds.size)
            self.overlaySceneWelcome.name="WelcomeScreenAquireView";
            scnView.overlaySKScene = overlaySceneWelcome
        }
    }
    
    func set4Players(){
        println("Player : 4 Players")
        modelGameScene.setNumberOfPlayersWithNotification(self.PlayersToBe4)
    }
    
    func set5Players(){
        println("Player : 5 Players")
        modelGameScene.setNumberOfPlayersWithNotification(self.PlayersToBe6)
    }
    
    func set6Players(){
        println("Player : 6 Players")
        modelGameScene.setNumberOfPlayersWithNotification(self.PlayersToBe6)
    }
    
    func doStart()
    {
        println("Player : start")
        let scnView = self.view as! SCNView
        self.overlaySceneWelcome.hidden = true
        self.overlaySceneGame = GameSceneView(size: self.view.bounds.size)
        scnView.overlaySKScene = self.overlaySceneGame
        scnView.scene =  self.gameBoard
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
