//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

// v 1.0 -  State, Prototype, command

import Foundation

public enum Player: CaseIterable {
    case first
    case second
    case computer
    
    var next: Player {
        switch self {
        case .first:
            if (Game.shared.gameType == .human || Game.shared.gameType == .humanFive) {return .second} else {return .computer}
        case .second,.computer:
            return .first
        
        }
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first: return XView()
        case .second, .computer: return OView()
        }
    }
}
