//Created by chizztectep on 25.03.2023

// v.1.0.0

import Foundation
import UIKit



protocol GameSessionDelegate : AnyObject {
    func setQuestionPosition(id: Int)
    func setQA(qa: StaticQA)
    func setCurrentValue(value: Int)
    func getQuestionPosition() -> Int
}

/** класс для хранения состояния текущей игры */
class GameSession {
    //  при создании класса начальная ставка
    var currentValue: Int = 100
    // начальный номер вопроса = 1
    var questionPosition: Int = 0
    var qa: StaticQA?

    
    
    func winPercent() -> Int? {
      guard let qa = qa else {return nil}
      return questionPosition/100 * qa.questions.count
    }
    

    
    
}

extension GameSession: GameSessionDelegate {
    func setQuestionPosition(id: Int) {
        self.questionPosition = id
    }
    
    func setQA(qa: StaticQA) {
        self.qa = qa
    }
    
    func setCurrentValue(value: Int) {
        self.currentValue = value
    }
    
    func getQuestionPosition() -> Int {
        return self.questionPosition
    }
    
    
}


