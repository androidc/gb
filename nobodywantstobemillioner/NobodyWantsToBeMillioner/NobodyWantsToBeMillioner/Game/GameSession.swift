//Created by chizztectep on 25.03.2023 

import Foundation


 


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
    
    
    
   
    
    
    // установка StaticQA происходит через делегат в момент создания игры в ViewController
    
    
}
