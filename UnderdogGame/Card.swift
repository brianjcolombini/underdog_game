//
//  Card.swift
//  UnderdogGame
//
//  Created by Brian Colombini on 9/7/18.
//  Copyright © 2018 Brian Colombini. All rights reserved.
//

import Foundation

struct Card {
    
    var round = 1
    var team : Team
    var value = 0
    var isFlipped = false
    
    init(value: Int, team: Team, round: Int) {
        self.value = value
        self.team = team
        self.round = round
    }
    
}
