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
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        let cardId = cardButtons.index(of: sender)!
        flipCard(withNumber: cardId, on: sender)
    }
    
    func flipCard(withNumber number: Int, on button: UIButton) {
        if button.currentTitle == String(number) {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.1871772701, green: 0.3310747348, blue: 1, alpha: 1)
            button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        } else {
            button.setTitle(String(number), for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            button.layer.borderColor = #colorLiteral(red: 0.1871772701, green: 0.3310747348, blue: 1, alpha: 1)
        }
    }
    
}

