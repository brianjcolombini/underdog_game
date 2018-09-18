//
//  ViewController.swift
//  UnderdogGame
//
//  Created by Brian Colombini on 9/7/18.
//  Copyright © 2018 Brian Colombini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game = UnderdogGame()
    
    @IBOutlet weak var turnIndicatorView: UIView!
    
    @IBOutlet weak var leftTeamScoreLabel: UILabel!
    @IBOutlet weak var rightTeamScoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardId = cardButtons.index(of: sender) {
            game.chooseCard(at: cardId)
            updateViewFromModel()
        } else {
            print("OOPS: chosen card not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        if game.turnIndicator != nil {
            turnIndicatorView.backgroundColor = UIColor(cgColor: game.turnIndicator!.color)
        }
        
        leftTeamScoreLabel.text = String(game.teams[0].firstStageScore)
        rightTeamScoreLabel.text = String(game.teams[1].firstStageScore)
        
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
    
    override func viewDidLoad() {
        leftTeamScoreLabel.textColor = UIColor(cgColor: game.teams[0].color)
        rightTeamScoreLabel.textColor = UIColor(cgColor: game.teams[1].color)
        updateViewFromModel()
    }
    
}

