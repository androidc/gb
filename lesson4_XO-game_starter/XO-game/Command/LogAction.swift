//Created by chizztectep on 10.04.2023

// v 1.0 -  State, Prototype, command

import Foundation

public enum LogAction {
    case playerInput(player: Player,position: GameboardPosition)
    case gameFinish(winner: Player?)
    case restartGame
}

public func log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LogerInvoker.shared.addCommand(command)
}
