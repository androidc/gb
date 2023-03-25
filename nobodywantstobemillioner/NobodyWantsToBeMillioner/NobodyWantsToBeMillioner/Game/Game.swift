//Created by chizztectep on 25.03.2023

// v.1.0.0

import Foundation

class Game {
    var gameSession: GameSession?
    private(set) var records:[Record] = [] {
        didSet {
            try! recordsCaretaker.save(self.records)
        }
    }
    
    private let recordsCaretaker = RecordsCareTaker()
    
    init() {
        records = recordsCaretaker.retrieveRecords()
    }
    
    static let shared = Game()
    
    func addRecord(_ record: Record) {
        records.append(record)
    }
 
}
