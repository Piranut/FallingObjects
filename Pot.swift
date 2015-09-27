//
//  Pot.swift
//  FallingObjects
//
//  Created by Piranut Lapprathana on 7/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Pot: CCNode {
   
    
    weak var catchContainer: CCNode!
    weak var potTop: CCNode!
    weak var potBottom: CCNode!
    
    enum DrawingOrder: Int {
        case PotTop
        case FallingObject
        case PotBottom
    }
    
    func didLoadFromCCB() {
        potTop.zOrder = DrawingOrder.PotTop.rawValue
        potBottom.zOrder = DrawingOrder.PotBottom.rawValue
    }
    
}
