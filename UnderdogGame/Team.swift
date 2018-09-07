//
//  Team.swift
//  UnderdogGame
//
//  Created by Brian Colombini on 9/7/18.
//  Copyright © 2018 Brian Colombini. All rights reserved.
//

import Foundation
import UIKit

struct Team {
    
    var name = "TeamName"
    var color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
}
