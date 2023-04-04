//Created by chizztectep on 02.04.2023 

import Foundation

class HintUsageFacade {
    var currentQuestion: Int?
    var staticQA: StaticQA
    
    init(qa: StaticQA) {
        self.staticQA = qa
    }
    
    // MARK: - Private Functions
    /**
       Функция возвращает случайное число из массива, учитывая все элементы кроме заданного
          - Parameter exlude: элемент, который не участвует в рандомной выборке
          - Returns: случайный элемент из массива. этот элемент точно не равен заданному
     */
    private func returnRandExclude(with exclude:Int) -> Int {
       
        
        let array = [0,1,2,3]
        // Filter out the excluded number
        let filteredArray = array.filter {$0 != exclude}
        // Generate a random index within the bounds of the filtered array
        let randomIndex = Int(arc4random_uniform(UInt32(filteredArray.count)))
        // Return the element at the random index in the filtered array
        return filteredArray[randomIndex]
    }
    
    private func returnTwoRandExclude(with exclude: Int) -> [Int] {
        //  получаем id правильного ответа

        let firstId = returnRandExclude(with: exclude)
        var excludes = [firstId,exclude]
        
        let array = [0,1,2,3]
        
        let removeSet = Set(excludes)
        let filteredArray = array.filter { !removeSet.contains($0) }
        let secondId = Int(arc4random_uniform(UInt32(filteredArray.count)))
        
        return [firstId, filteredArray[secondId]]
        
        
    }
    
    //  MARK: - functions
    func callFriend() -> Int {
        
        /** переменная возвращает true в 50% случае*/
        var trueFalse: Bool {
            return arc4random_uniform(2) == 1
        }
        // проверка на то, что мы в игре и есть currentQuestion
        guard let currentQuestion = currentQuestion else {
            return 0
        }

    
        //  получаем id правильного ответа
        let wrightId = staticQA.getWrightAnswerIdByQuestionId(questionId: currentQuestion)
        // trueFalse вернет true в 50% случае
        if trueFalse {
            return wrightId
        } else {
           // вернуть рандомный id из 4-х , который не равен wrightid
            return returnRandExclude(with: wrightId)
            }
    }
    
    func AuditoryHelp() -> Int {
        
        /// Returns a random floating point number between 0.0 and 1.0, inclusive.
         var random: Double {
              return Double(arc4random()) / 0xFFFFFFFF
          }
        // проверка на то, что мы в игре и есть currentQuestion
        guard let currentQuestion = currentQuestion else {
            return 0
        }
        //  получаем id правильного ответа
        let wrightId = staticQA.getWrightAnswerIdByQuestionId(questionId: currentQuestion)
        
        //
        if random < 0.75 {
            return wrightId
        } else {
            // вернуть рандомный id из 4-х , который не равен wrightid
             return returnRandExclude(with: wrightId)
        }
    }
    
    // возвращает индексы двух неправильных ответов
    func fiftyFifty() -> [Int] {
        // проверка на то, что мы в игре и есть currentQuestion
        guard let currentQuestion = currentQuestion else {
            return [0]
        }
        //  получаем id правильного ответа
        let wrightId = staticQA.getWrightAnswerIdByQuestionId(questionId: currentQuestion)
        
      return returnTwoRandExclude(with: wrightId)
    }
    
    
    
    
    
}
