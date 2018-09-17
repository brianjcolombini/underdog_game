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
    var cardsCurrentlyInPlay : Array<Card> = []
    var roundWinners : Array<Team> = [] {
        didSet {
            let thisRoundWinner = roundWinners.last
            if thisRoundWinner != nil {
                thisRoundWinner!.firstRoundScore += 1
            }
        }
    }
    var gameWinner : Team? = nil
    
    func chooseCard(at index: Int) {
        if turnIndicator!.name == cards[index].team.name { // TO DO: use overloaded op
            if !cards[index].isFlipped {
                cards[index].isFlipped = true
                if cardsCurrentlyInPlay.count == 0 {
                    cardsCurrentlyInPlay += [cards[index]]
                } else if cardsCurrentlyInPlay.count == 1 {
                    cardsCurrentlyInPlay += [cards[index]]
                    evaluateRound()
                } else {
                    cardsCurrentlyInPlay = [cards[index]]
                }
                // other team's turn
                turnIndicator = turnIndicator!.name == teams[1].name ? teams[0] : teams[1]
            }
        }
    }
    
    func evaluateRound() {
        assert(cardsCurrentlyInPlay.count == 2, "count of cardsCurrentlyInPlay is \(cardsCurrentlyInPlay.count), expected 2")
        if cardsCurrentlyInPlay[0].value > cardsCurrentlyInPlay[1].value {
            roundWinners += [cardsCurrentlyInPlay[0].team]
        } else if cardsCurrentlyInPlay[0].value < cardsCurrentlyInPlay[1].value {
            roundWinners += [cardsCurrentlyInPlay[1].team]
        }
        else {
            print("tie")
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
                // create card for this team and round, with random card value
                let card = Card(value: MAX_VALUE.arc4random, team: team, round: 1)
                cards += [card]
            }
        }
        // set team to have first turn
        let randomTeamIndex = teams.count.arc4random
        turnIndicator = teams[randomTeamIndex]
    }

}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
