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
    let NUM_CARDS_PER_TEAM_FIRST_STAGE = 3
    let NUM_CARDS_UNDERDOG_STAGE = 3
    
    var teams : Array<Team> = []
    var cards : Array<Card> = []
    var stage = 1
    var turnIndicator: Team? = nil
    var cardsCurrentlyInPlay : Array<Card> = []
    var numCardsFlippedThisRound = 0
    var roundWinners : Array<Team> = [] {
        didSet {
            let thisRoundWinner = roundWinners.last
            if thisRoundWinner != nil {
                thisRoundWinner!.firstStageScore += 1
            }
        }
    }
    var gameWinner : Team? = nil
    
    func chooseCard(at index: Int) {
        numCardsFlippedThisRound += 1
        if turnIndicator!.name == cards[index].team!.name { // TO DO: use overloaded op
            if !cards[index].isFlipped {
                cards[index].isFlipped = true
                cardsCurrentlyInPlay += [cards[index]]
                // in first stage of game
                if stage == 1 {
                    // if first card in round
                    if cardsCurrentlyInPlay.count == 1 {
                        // other team's turn
                        alternateTurnIndicator()
                    // if second card in round
                    } else if cardsCurrentlyInPlay.count == 2 {
                        // evaluate round
                        evaluateFirstStageRound()
                    // if more than two cards currently in play, reset to new round with just this card
                    } else {
                        cardsCurrentlyInPlay = [cards[index]]
                        // other team's turn
                        alternateTurnIndicator()
                    }
                }
            }
        }
        // if all cards flipped, evaluate stage of game
        let numEligibleCards = stage == 1 ? NUM_CARDS_PER_TEAM_FIRST_STAGE * teams.count : NUM_CARDS_UNDERDOG_STAGE
        if numCardsFlippedThisRound == numEligibleCards {
            evaluateGameStage()
        // in stage 2, if only one card left unflipped, underdog's turn (alternate turn indicator)
        } else if stage == 2, (numEligibleCards - numCardsFlippedThisRound) == 1 {
            alternateTurnIndicator()
        }
    }
    
    func alternateTurnIndicator() {
        turnIndicator = turnIndicator!.name == teams[1].name ? teams[0] : teams[1]
    }
    
    func evaluateFirstStageRound() {
        assert(cardsCurrentlyInPlay.count == 2, "count of cardsCurrentlyInPlay is \(cardsCurrentlyInPlay.count), expected 2")
        if cardsCurrentlyInPlay[0].value > cardsCurrentlyInPlay[1].value {
            roundWinners += [cardsCurrentlyInPlay[0].team!]
        } else if cardsCurrentlyInPlay[0].value < cardsCurrentlyInPlay[1].value {
            roundWinners += [cardsCurrentlyInPlay[1].team!]
        }
        else {
            print("tie")
        }
    }
    
    func evaluateGameStage() {
        if stage == 1 {
            // if either team shutout in first stage, other team wins
            if teams[0].firstStageScore == 0 || teams[1].firstStageScore == 0 {
                gameWinner = roundWinners.first
                // TO DO: Winning page
                print("game over")
                print("\(gameWinner?.name ?? "ERROR") wins!")
            // else, game moves on to stage 2
            } else {
                stage = 2
                numCardsFlippedThisRound = 0
                // turn indicator to first stage winner
                turnIndicator = teams[0].firstStageScore > teams[1].firstStageScore ? teams[0] : teams[1]
                createUnderdogStage()
            }
        }
    }
    
    func createUnderdogStage() {
        var underdogStageCardIndex = NUM_CARDS_PER_TEAM_FIRST_STAGE * 2
        for roundWinnerTeam in roundWinners {
            cards[underdogStageCardIndex].team = roundWinnerTeam
            underdogStageCardIndex += 1
        }
    }
    
    // initialize Underdog game
    init() {
        // TEMP: Testing teams of Red and Blue
        teams += [Team(name: "Blue", color: #colorLiteral(red: 0.1871772701, green: 0.3310747348, blue: 1, alpha: 1)), Team(name: "Red", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))]
        // for each team
        for team in teams {
            // for each first stage card
            for _ in 0..<NUM_CARDS_PER_TEAM_FIRST_STAGE {
                // create card for this team and stage, with random card value
                let firstStageCard = Card(value: MAX_VALUE.arc4random, team: team, stage: 1)
                cards += [firstStageCard]
            }
        }
        for _ in 0..<NUM_CARDS_UNDERDOG_STAGE {
            // create teamless card for underdog stage
            let teamlessUnderdogStageCard = Card(value: MAX_VALUE.arc4random, team: nil, stage: 2)
            cards += [teamlessUnderdogStageCard]
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
