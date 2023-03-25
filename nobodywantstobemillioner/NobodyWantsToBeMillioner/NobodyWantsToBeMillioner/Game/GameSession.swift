//Created by chizztectep on 25.03.2023 

import Foundation
import UIKit



protocol GameSessionDelegate : AnyObject {
    func setQuestionId(id: Int)
    func setQA(qa: StaticQA)
    func setCurrentValue(value: Int)
    func getQuestionId() -> Int
}

/** класс для хранения состояния текущей игры */
class GameSession {
    //  при создании класса начальная ставка
    var currentValue: Int = 100
    // начальный номер вопроса = 1
    var questionId: Int = 0
    var qa: StaticQA?

    
    
    func winPercent() -> Int? {
      guard let qa = qa else {return nil}
      return questionId/100 * qa.questions.count
    }
    

    
    
}

extension GameSession: GameSessionDelegate {
    func setQuestionId(id: Int) {
        self.questionId = id
    }
    
    func setQA(qa: StaticQA) {
        self.qa = qa
    }
    
    func setCurrentValue(value: Int) {
        self.currentValue = value
    }
    
    func getQuestionId() -> Int {
        return self.questionId
    }
    
    
}


