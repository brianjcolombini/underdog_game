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
    
    @IBOutlet private weak var leftTeamScoreLabel: UILabel! {
        didSet {
            updateFirstStageScoreLabel(team: game.teams[0], label: leftTeamScoreLabel)
        }
    }
    @IBOutlet private weak var rightTeamScoreLabel: UILabel! {
        didSet {
            updateFirstStageScoreLabel(team: game.teams[1], label: rightTeamScoreLabel)
        }
    }
    
    // update first stage score label with attributed string
    private func updateFirstStageScoreLabel(team : Team, label: UILabel) {
        let scoreLabelAttributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor(cgColor: team.color)
        ]
        let scoreLabelAttributedString = NSAttributedString(string: "\(team.firstStageScore)", attributes: scoreLabelAttributes)
        label.attributedText = scoreLabelAttributedString
    }
    
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
        updateFirstStageScoreLabel(team : game.teams[0], label: leftTeamScoreLabel)
        updateFirstStageScoreLabel(team: game.teams[1], label: rightTeamScoreLabel)
        
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
    
    // when view first loads, initialize UI with updateViewFromModel() (original model)
    override func viewDidLoad() {
        updateViewFromModel()
    }
    
}

