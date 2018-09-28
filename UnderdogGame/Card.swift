//
//  Card.swift
//  UnderdogGame
//
//  Created by Brian Colombini on 9/7/18.
//  Copyright © 2018 Brian Colombini. All rights reserved.
//

import Foundation

struct Card {
    
    var id : Int
    private(set) var stage : Int
    var team : Team?
    private(set) var value = 0
    var isFlipped = false
    
    private static let MAX_VALUE = 100
    private static var idIncrementer = 0
    private static var usedValues : Set<Int> = []
    
    private static func getId() -> Int {
        idIncrementer += 1
        return idIncrementer
    }
    
    private static func getUniqueValue() -> Int {
        var newValue : Int
        repeat {
            newValue = MAX_VALUE.arc4random
        } while usedValues.contains(newValue)
        usedValues.insert(newValue)
        return newValue
    }
    
    init(team: Team?, stage: Int) {
        self.id = Card.getId()
        self.value = Card.getUniqueValue()
        self.team = team
        self.stage = stage
    }
    
}
