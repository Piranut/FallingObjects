//
//  TimedGameMode.swift
//  FallingObjects
//
//  Created by Piranut Lapprathana on 7/6/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation


class TimedGameMode: GameMode {
    
    
    var timeLabel: CCLabelTTF!
    var pointsLabel: CCLabelTTF!
    
    private let highscoreKey = "TimedGameMode.Highscore"
    private var newHighscore = false
    
    let minPoints = 0
    let minTime = 0.0
    
    private(set) var userInterface: CCNode!
    
    private var time: CCTime = 10 {
        didSet {
        updateTimeDisplay(time)
        }
    }
    
    private var points: Int = 0 {
        didSet {
            updatePointsDisplay(points)
        }
    }
    
    init() {
        userInterface = CCBReader.load("TimedModeUI", owner:self)
        updatePointsDisplay(points)
        updateTimeDisplay(time)
    }
    
    func updatePointsDisplay(points: Int) {
        pointsLabel.string = "Points: \(points)"
    }
    
    func updateTimeDisplay(time : CCTime) {
        timeLabel.string = "Time: \(Int(time))"
    }
    

    
    //MARK: protocol conformance
    
    
    func gameplay(mainScene: MainScene, droppedFallingObject: FallingObject) {
        if (droppedFallingObject.type == .Good) {
            points = max(points - 1, minPoints)
        }
    }
    
    func gameplay(mainScene: MainScene, caughtFallingObject: FallingObject) {
        switch (caughtFallingObject.type) {
        case .Bad:
            points = max(points - 1, minPoints)
        case .Good:
            points += 1
        }
    }
    
    func gameplayStep(mainScene: MainScene, delta: CCTime) -> GameOver {
        time -= delta
        return !(time > minTime)
    }
    
    func highscoreMessage() -> String {
        let pointsText = "point".pluralize(points)
        
        if(!newHighscore) {
            let oldHighscore = NSUserDefaults.standardUserDefaults().integerForKey(highscoreKey)
            let oldHighscoreText = "point".pluralize(oldHighscore)
            
            return "You have scored \(points) \(pointsText)! Your highscore is \(Int(oldHighscore)) \(oldHighscoreText)."
        } else {
            
            return "You have reached a new highscore of \(points) \(pointsText)!"
        }
    }
    
    func saveHighscore() {
        let oldHighscore = NSUserDefaults.standardUserDefaults().integerForKey(highscoreKey)
        
        if(points > oldHighscore) {
            // if this score is larger than the old highscore, store it
            NSUserDefaults.standardUserDefaults().setInteger(points, forKey: highscoreKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            newHighscore = true
        } else {
            newHighscore = false
        }
    }
    
}