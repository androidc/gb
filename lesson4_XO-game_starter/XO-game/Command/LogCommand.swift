//Created by chizztectep on 10.04.2023

// v 1.0 -  State, Prototype, command

import Foundation

class LogCommand {
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    var logMessage: String {
        switch action {
        case .playerInput(let player, let position):
            return "\(player) placed mark at \(position)"
        case .gameFinish(let winner):
            if let winner = winner {
                return "\(winner) win game"
            } else {
                return "nobody win"
            }
            
        case .restartGame:
            return "game is restarted"
        }
    }
}
