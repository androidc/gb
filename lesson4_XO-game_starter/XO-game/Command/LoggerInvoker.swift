//Created by chizztectep on 10.04.2023

// v 1.0 -  State, Prototype, command

import Foundation

class LogerInvoker {
    static let shared = LogerInvoker()
    
    // MARK: - Private Properties
    private let logger = LogReceiver()
    private let batchSize = 1
    
    private var commands: [LogCommand] = []
    
    func addCommand(_ command: LogCommand) {
        commands.append(command)
        executeCommandsIfNeeded()
    }
    
    private func executeCommandsIfNeeded() {
        guard commands.count >= batchSize else {return}
       
        // commands.forEach {self.logger.writeMessageToLog($0.logMessage)}
        commands.forEach { command in
            self.logger.writeMessageToLog(command.logMessage)
        }
        commands = []
    }
    
}
