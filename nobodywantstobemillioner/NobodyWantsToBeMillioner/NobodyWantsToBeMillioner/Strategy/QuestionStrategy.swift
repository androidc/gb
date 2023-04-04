//Created by chizztectep on 29.03.2023
// v.1.0.1 - hw pattern l2 strategy, facade, observer, builder

import Foundation

protocol QuestionStrategy {

    
    func setQA() -> StaticQA
  
    
}

class StaticQAStrategy:QuestionStrategy{
  
    
    func setQA() -> StaticQA {
        return StaticQA()
    }
}

class RandomQAStrategy:QuestionStrategy{
   
    
    func setQA() -> StaticQA {
        let qa =  StaticQA()
        qa.questions.shuffle()
        return qa
    }
    
    
}
