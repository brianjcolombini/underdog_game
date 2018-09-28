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
    
    let NUM_CARDS_PER_TEAM_FIRST_STAGE = 3
    let NUM_CARDS_UNDERDOG_STAGE = 3
    
    var turnIndicator: Team? = nil
    private(set) var teams : Array<Team> = []
    private(set) var cards : Array<Card> = []
    private(set) var stage = 1
    private var numEligibleCardsThisStage: Int { // num cards visible on screen
        get {
            if stage == 1 {
                return NUM_CARDS_PER_TEAM_FIRST_STAGE * teams.count
            } else {
                return NUM_CARDS_UNDERDOG_STAGE
            }
        }
    }
    private var numCardsFlippedThisStage = 0
    private var cardsCurrentlyInPlay : Array<Card> = [] // num cards active in current round
    private(set) var roundWinners : Array<Team> = [] {
        didSet {
            let thisRoundWinner = roundWinners.last
            if thisRoundWinner != nil {
                thisRoundWinner!.firstStageScore += 1
            }
        }
    }
    private var firstStageWinner : Team? = nil
    private var gameWinner : Team? = nil {
        didSet {
            // TO DO: game over animation
            print("game over")
            print("\(gameWinner?.name ?? "ERROR") wins!")
        }
    }
    
    // when card is chosen, and card matches turn indicator and is not yet flipped
    func chooseCard(at index: Int) {
        if turnIndicator!.name == cards[index].team!.name { // TO DO: use overloaded op
            if !cards[index].isFlipped {
                // update model accordingly
                cards[index].isFlipped = true
                numCardsFlippedThisStage += 1
                cardsCurrentlyInPlay += [cards[index]]
                // if first stage of game
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
        if numCardsFlippedThisStage == numEligibleCardsThisStage {
            evaluateGameStage()
        // in stage 2, if only one card left unflipped, underdog's turn (alternate turn indicator)
        } else if stage == 2, (numEligibleCardsThisStage - numCardsFlippedThisStage) == 1 {
            alternateTurnIndicator()
        }
    }
    
    private func alternateTurnIndicator() {
        turnIndicator = turnIndicator!.name == teams[1].name ? teams[0] : teams[1]
    }
    
    // evaluate round in stage 1
    private func evaluateFirstStageRound() {
        // cardsCurrentlyInPlay must be 2 and 2 cards cannot have same value
        assert(cardsCurrentlyInPlay.count == 2, "count of cardsCurrentlyInPlay is \(cardsCurrentlyInPlay.count), expected 2")
        assert(cardsCurrentlyInPlay[0].value != cardsCurrentlyInPlay[1].value, "multiple cards have same value")
        // determine winner of round (card with greater value), append to roundWinners
        if cardsCurrentlyInPlay[0].value > cardsCurrentlyInPlay[1].value {
            roundWinners += [cardsCurrentlyInPlay[0].team!]
        } else {
            roundWinners += [cardsCurrentlyInPlay[1].team!]
        }
    }
    
    // evaluate stage of game
    private func evaluateGameStage() {
        // if end of first stage
        if stage == 1 {
            // if either team shutout in first stage, other team wins
            if teams[0].firstStageScore == 0 || teams[1].firstStageScore == 0 {
                gameWinner = roundWinners.first
            // else, game moves on to stage 2
            } else {
                stage = 2
                numCardsFlippedThisStage = 0
                // turn indicator to first stage winner
                firstStageWinner = teams[0].firstStageScore > teams[1].firstStageScore ? teams[0] : teams[1]
                turnIndicator = firstStageWinner
                createUnderdogStage()
            }
        // if end of Underdog stage
        } else {
            // find card in underdog stage with max value
            var underdogStageMaxValueCard = cardsCurrentlyInPlay[0]
            for underdogStageCardCurrentlyInPlay in cardsCurrentlyInPlay {
                if underdogStageCardCurrentlyInPlay.value > underdogStageMaxValueCard.value {
                    underdogStageMaxValueCard = underdogStageCardCurrentlyInPlay
                }
            }
            // team with max value card wins game
            gameWinner = underdogStageMaxValueCard.team
        }
    }
    
    // create underdog stage of game (stage 2)
    private func createUnderdogStage() {
        // reset cardsCurrentlyInPlay
        cardsCurrentlyInPlay = []
        // start with first of unspecified cards that were hidden to this point
        var underdogStageCardIndex = NUM_CARDS_PER_TEAM_FIRST_STAGE * 2
        // for each first stage round winner, assign team to underdog stage card
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
                let firstStageCard = Card(team: team, stage: 1)
                cards += [firstStageCard]
            }
        }
        for _ in 0..<NUM_CARDS_UNDERDOG_STAGE {
            // create hidden teamless card for underdog stage
            let teamlessUnderdogStageCard = Card(team: nil, stage: 2)
            cards += [teamlessUnderdogStageCard]
        }
        // set random team to have first turn
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
