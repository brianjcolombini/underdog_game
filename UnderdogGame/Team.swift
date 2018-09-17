//
//  Team.swift
//  UnderdogGame
//
//  Created by Brian Colombini on 9/7/18.
//  Copyright © 2018 Brian Colombini. All rights reserved.
//

import Foundation
import UIKit

class Team {
    
    var name : String
    var color : CGColor
    var firstRoundScore = 0
    
    init(name: String, color: CGColor) {
        self.name = name
        self.color = color
    }
    
}

// TO DO: overload operator?? to use in UnderdogGame
//extension Team: Equatable {
//    static func ==(lhs: Team, rhs: Team) -> Bool {
//        return lhs.name == rhs.name
//    }
//}
