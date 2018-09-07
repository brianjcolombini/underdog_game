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
    var round : Int
    var team : Team
    var value = 0
    var isFlipped = false
    
    static var idIncrementer = 0
    
    static func getId() -> Int {
        idIncrementer += 1
        return idIncrementer
    }
    
    init(value: Int, team: Team, round: Int) {
        self.id = Card.getId()
        self.value = value
        self.team = team
        self.round = round
    }
    
}
