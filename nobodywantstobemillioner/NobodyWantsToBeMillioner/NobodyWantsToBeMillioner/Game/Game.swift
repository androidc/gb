//Created by chizztectep on 25.03.2023 

import Foundation

class Game {
    var gameSession: GameSession?
    private(set) var records:[Record] = []
    
    static let shared = Game()
    
    func addRecord(_ record: Record) {
        records.append(record)
    }
 
}
