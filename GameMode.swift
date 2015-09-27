//
//  GameMode.swift
//  FallingObjects
//
//  Created by Piranut Lapprathana on 7/6/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

typealias GameOver = Bool

protocol GameMode: class {
    
    // Reference to the UI node that is specific to this game mode
    var userInterface: CCNode!  { get }
    
    func gameplay(mainScene:MainScene, droppedFallingObject: FallingObject)
    
    func gameplay(mainScene:MainScene, caughtFallingObject: FallingObject)
    
    func gameplayStep(mainScene:MainScene, delta: CCTime) -> GameOver
    
    func highscoreMessage() -> String
    
    func saveHighscore() 
    
}