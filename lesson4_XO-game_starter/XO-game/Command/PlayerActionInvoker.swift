//Created by chizztectep on 14.04.2023

// v 1.0 -  State, Prototype, command

import Foundation

class PlayerActionInvoker {
    static let shared = PlayerActionInvoker()
    
    // MARK: - Private Properties
    private let batchSize = 10
    
    private var commands: [Command] = []
    
    func addCommand(_ command: Command) {
        commands.append(command)
    }
    
    func executeCommands() {
        commands.forEach { command in
            command.execute()
        }
        commands = []
    }
    
}
