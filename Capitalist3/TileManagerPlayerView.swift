//
//  TileManagerPlayerView.swift
//  Capitalist3
//
//  Created by Carl Mitchell on 8/14/15.
//  Copyright (c) 2015 Carl Mitchell and Brad Geren. All rights reserved.
//

import UIKit
import SpriteKit


class TileManagerPlayerView: SKScene {
    
    var listOfPlayers : [PlayerModel] = []
    
    override init(size: CGSize){
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Overload the addPlayer Function
    func addPlayers (player1 : PlayerModel,player2: PlayerModel, player3: PlayerModel) {
         listOfPlayers.append(player1)
         listOfPlayers.append(player2)
         listOfPlayers.append(player3)
    }
    func addPlayers (player1 : PlayerModel,player2: PlayerModel, player3: PlayerModel, player4 : PlayerModel) {
         listOfPlayers.append(player1)
         listOfPlayers.append(player2)
         listOfPlayers.append(player3)
         listOfPlayers.append(player4)
    }
    func addPlayers (player1 : PlayerModel,player2: PlayerModel, player3: PlayerModel, player4 : PlayerModel, player5: PlayerModel) {
         listOfPlayers.append(player1)
         listOfPlayers.append(player2)
         listOfPlayers.append(player3)
         listOfPlayers.append(player4)
         listOfPlayers.append(player5)
    }
    func addPlayers (player1 : PlayerModel,player2: PlayerModel, player3: PlayerModel, player4 : PlayerModel, player5: PlayerModel,player6: PlayerModel) {
         listOfPlayers.append(player1)
         listOfPlayers.append(player2)
         listOfPlayers.append(player3)
         listOfPlayers.append(player4)
         listOfPlayers.append(player5)
         listOfPlayers.append(player6)
    }
    
    override func didMoveToView(view: SKView) {
        var iCount = 0.0
        for player in self.listOfPlayers{
            let lblPlayerNode: SKLabelNode = SKLabelNode(text: player.name)
            lblPlayerNode.name = player.name
            lblPlayerNode.position = CGPointMake(self.view!.bounds.width/2, 100.0 + CGFloat(iCount))
            iCount+=100.0
            self.addChild(lblPlayerNode)
        }
    }
}
