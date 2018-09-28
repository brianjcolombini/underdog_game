//
//  ViewController.swift
//  UnderdogGame
//
//  Created by Brian Colombini on 9/7/18.
//  Copyright © 2018 Brian Colombini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var game = UnderdogGame()
    
    @IBOutlet private weak var turnIndicatorView: UIView!
    
    @IBOutlet private weak var leftTeamScoreLabel: UILabel!
    @IBOutlet private weak var rightTeamScoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    // if card button touched, call chooseCard in model with given index, and then update view
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardId = cardButtons.index(of: sender) {
            game.chooseCard(at: cardId)
            updateViewFromModel()
        } else {
            print("OOPS: chosen card not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        // update color of turn indicator with appropriate team's color
        if game.turnIndicator != nil {
            turnIndicatorView.backgroundColor = UIColor(cgColor: game.turnIndicator!.color)
        }
        
        // update first stage score labels
        leftTeamScoreLabel.text = String(game.teams[0].firstStageScore)
        rightTeamScoreLabel.text = String(game.teams[1].firstStageScore)
        
        // for each card button, show as flipped or not flipped accordingly
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.stage == game.stage {
                button.isHidden = false
                if card.isFlipped {
                    button.setTitle(String(card.value), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    button.layer.borderColor = card.team!.color
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = UIColor(cgColor: card.team!.color)
                    button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                }
            } else {
                button.isHidden = true
            }
        }
    }
    
    // when view first loads, set first stage score label color and initialize UI with updateViewFromModel() (original model)
    override func viewDidLoad() {
        leftTeamScoreLabel.textColor = UIColor(cgColor: game.teams[0].color)
        rightTeamScoreLabel.textColor = UIColor(cgColor: game.teams[1].color)
        updateViewFromModel()
    }
    
}

