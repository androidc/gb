//Created by chizztectep on 25.03.2023 

import Foundation

class StaticQA {
    var questions: [Questions]
    var answers: [Answers]
    
    init() {
        self.questions = []
        
        let question = Questions(id: 0, text: "Какое животное является символом компании 'Puma'?")
        self.questions.append(question)
        let question1 = Questions(id: 1, text: "Какой город называют 'городом мостов'?")
        self.questions.append(question1)
        let question2 = Questions(id: 2, text: "Какой вид спорта не является олимпийским?")
        self.questions.append(question2)
        let question3 = Questions(id: 3, text: "Кто является автором книги '1984'?")
        self.questions.append(question3)
        let question4 = Questions(id: 4, text: "Какая валюта используется в Швейцарии?")
        self.questions.append(question4)
        let question5 = Questions(id: 5, text: "Какой газ является самым распространенным в атмосфере Земли?")
        self.questions.append(question5)
//        let question6 = Questions(id: 6, text: "Какая страна является родиной Карате?")
//        self.questions.append(question6)
//        let question7 = Questions(id: 7, text: "Какой химический элемент является основным компонентом стекла?")
//        self.questions.append(question7)
//        let question8 = Questions(id: 8, text: "Какой цвет получается при смешивании синего и желтого?")
//        self.questions.append(question8)
//        let question9 = Questions(id: 9, text: "Какой фильм получил Оскар в категории 'Лучший фильм' в 2020 году?")
//        self.questions.append(question9)
        
        
        
        self.answers = []
        
        // ответы к первому вопросу
        let answer1 = Answers(questionId: 0, id: 0, text:  "лев", bingo: false)
        answers.append(answer1)
        let answer2 = Answers(questionId: 0, id: 1, text:  "тигр", bingo: false)
        answers.append(answer2)
        let answer3 = Answers(questionId: 0, id: 2, text:  "пума", bingo: true)
        answers.append(answer3)
        let answer4 = Answers(questionId: 0, id: 3, text:  "ягуар", bingo: false)
        answers.append(answer4)
        
        // ответы к второму вопросу
        let answer12 = Answers(questionId: 1, id: 0, text:  "Париж", bingo: false)
        answers.append(answer12)
        let answer22 = Answers(questionId: 1, id: 1, text:  "Венеция", bingo: true)
        answers.append(answer22)
        let answer32 = Answers(questionId: 1, id: 2, text:  "Санкт-Петербург", bingo: false)
        answers.append(answer32)
        let answer42 = Answers(questionId: 1, id: 3, text:  "Лондон", bingo: false)
        answers.append(answer42)
        
      
        let answer13 = Answers(questionId: 2, id: 0, text:  "рагби", bingo: true)
        answers.append(answer13)
        let answer23 = Answers(questionId: 2, id: 1, text:  "гребля", bingo: false)
        answers.append(answer23)
        let answer33 = Answers(questionId: 2, id: 2, text:  "бокс", bingo: false)
        answers.append(answer33)
        let answer43 = Answers(questionId: 2, id: 3, text:  "хоккей", bingo: false)
        answers.append(answer43)
        
        let answer14 = Answers(questionId: 3, id: 0, text:  "Эрнест Хемингуэй", bingo: false)
        answers.append(answer14)
        let answer24 = Answers(questionId: 3, id: 1, text:  "Джордж Оруэлл", bingo: true)
        answers.append(answer24)
        let answer34 = Answers(questionId: 3, id: 2, text:  "Рэй Брэдбери", bingo: false)
        answers.append(answer34)
        let answer44 = Answers(questionId: 3, id: 3, text:  "Айзек Азимов", bingo: false)
        answers.append(answer44)
        
        let answer15 = Answers(questionId: 4, id: 0, text:  "евро", bingo: false)
        answers.append(answer15)
        let answer25 = Answers(questionId: 4, id: 1, text:  "доллар", bingo: false)
        answers.append(answer25)
        let answer35 = Answers(questionId: 4, id: 2, text:  "франк", bingo: true)
        answers.append(answer35)
        let answer45 = Answers(questionId: 4, id: 3, text:  "рубль", bingo: false)
        answers.append(answer45)
        
        let answer16 = Answers(questionId: 5, id: 0, text:  "кислород", bingo: false)
        answers.append(answer16)
        let answer26 = Answers(questionId: 5, id: 1, text:  "углекислый газ", bingo: false)
        answers.append(answer26)
        let answer36 = Answers(questionId: 5, id: 2, text:  "азот", bingo: true)
        answers.append(answer36)
        let answer46 = Answers(questionId: 5, id: 3, text:  "водород", bingo: false)
        answers.append(answer46)
        
    }
    
    //MARK: - functions
    
    func getAnswersByQuestionId(questionId: Int) -> [Answers] {
        var answers: [Answers] = []
        for answer in self.answers {
            if answer.questionId == questionId {
                answers.append(answer)
            }
        }
        return answers
    }
    
    
}
