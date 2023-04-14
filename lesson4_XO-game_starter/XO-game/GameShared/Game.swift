//Created by chizztectep on 11.04.2023
// v 1.0 -  State, Prototype, command

import Foundation

class Game {
    static let shared = Game()
    
     var gameType: GameType = .human
     var firstPositions:[GameboardPosition] = []
     var secondPositions:[GameboardPosition] = []
}
