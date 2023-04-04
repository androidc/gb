//Created by chizztectep on 25.03.2023

// v.1.0.0
// v.1.0.1 - hw pattern l2 strategy, facade, observer, builder

import Foundation

class Game {
    var gameSession: GameSession?
    var choosenStrategy: ChoosenStrategy = .staticStrategy
    
    private(set) var records:[Record] = [] {
        didSet {
            try! recordsCaretaker.save(self.records)
        }
    }
    
    private(set) var questions:QuestionsForCareTaker  {
        didSet {
            try! questionsCaretaker.save(self.questions)
        }
    }
    
    private let recordsCaretaker = RecordsCareTaker()
    private let questionsCaretaker = QuestionsCareTaker()
    
    init() {
        records = recordsCaretaker.retrieveRecords()
        questions = questionsCaretaker.retrieveRecords()
        
    }
    
    static let shared = Game()
    
    func addRecord(_ record: Record) {
        records.append(record)
    }
    
    func setQuestions(_ questions: QuestionsForCareTaker) {
        self.questions = questions
    }
 
}
