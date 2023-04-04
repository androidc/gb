//Created by chizztectep on 25.03.2023

// v.1.0.0

import Foundation
import UIKit



protocol GameSessionDelegate : AnyObject {
    func setQuestionPosition(id: Int)
    func setQA(qa: StaticQA)
    func setCurrentValue(value: Int)
    func getQuestionPosition() -> Int
    func setChoosenStrategy(strategy: ChoosenStrategy)
   
}

/** класс для хранения состояния текущей игры */
class GameSession {
    //  при создании класса начальная ставка
    var currentValue: Int = 100
    // начальный номер вопроса = 1
    var questionPosition = Observable<Int>(0)
    var qa: StaticQA?
    var choosenStrategy: ChoosenStrategy = .staticStrategy
    var hintUsageFacade: HintUsageFacade?
    
    

    
    
    func winPercent() -> Double? {
        guard let qa = self.qa else {return nil}
        let q:Double = Double(self.questionPosition.value)/Double(qa.questions.count) * 100
        return q.rounded(.towardZero)
    }
    

    
    
}

extension GameSession: GameSessionDelegate {
    
    func setChoosenStrategy(strategy: ChoosenStrategy) {
        self.choosenStrategy = strategy
    }
    
    func setQuestionPosition(id: Int) {
        self.questionPosition.value = id
        self.hintUsageFacade?.currentQuestion = id
    
    }
    
    func setQA(qa: StaticQA) {
        self.qa = qa
        self.hintUsageFacade = HintUsageFacade(qa: qa)
        
        
    }
    
    func setCurrentValue(value: Int) {
        self.currentValue = value
    }
    
    func getQuestionPosition() -> Int {
        return self.questionPosition.value
    }
    
    
}


