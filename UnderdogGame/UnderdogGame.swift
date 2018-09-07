//
//  UnderdogGame.swift
//  UnderdogGame
//
//  Created by Brian Colombini on 9/7/18.
//  Copyright © 2018 Brian Colombini. All rights reserved.
//

import Foundation
import UIKit

class UnderdogGame {
    
    let MAX_VALUE = 100
    let CARDS_PER_TEAM_FIRST_ROUND = 3
    
    var teams : Array<Team> = []
    var cards : Array<Card> = []
    var turnIndicator: Team? = nil
    var firstRoundWinner : String? = nil
    var finalRoundWinner : String? = nil
    
    func chooseCard(at index: Int) {
        if !cards[index].isFlipped {
            cards[index].isFlipped = true
        }
    }
    
    // initialize Underdog game
    init() {
        // TEMP: Testing teams of Red and Blue
        teams += [Team(name: "Blue", color: #colorLiteral(red: 0.1871772701, green: 0.3310747348, blue: 1, alpha: 1)), Team(name: "Red", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))]
        // for each team
        for team in teams {
            // for each first round card
            for _ in 0..<CARDS_PER_TEAM_FIRST_ROUND {
                // create card for this team and round with random card value
                var thisCardValue = Int(arc4random_uniform(UInt32(MAX_VALUE)))
                let card = Card(value: thisCardValue, team: team, round: 1)
                cards += [card]
            }
        }
    }
    
}
