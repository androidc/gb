//Created by chizztectep on 10.04.2023 

import Foundation

protocol GameState {
    var isCompleted: Bool {get}
    func begin()
    
    func addMark(at position: GameboardPosition)
}
