//Created by chizztectep on 10.04.2023

// v 1.0 -  State, Prototype, command

import Foundation

protocol GameState {
    var isCompleted: Bool {get}
    func begin()
    
    func addMark(at position: GameboardPosition)
}
