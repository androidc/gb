//Created by chizztectep on 01.04.2023
// v.1.0.1 - hw pattern l2 strategy, facade, observer, builder

import UIKit

class AddQuestionViewController: UIViewController {
    
    // MARK: - private vars
    
    private var qa: StaticQA = StaticQA()
    private var alerts: Alerts?
    private var allWright: Bool = true
    private var questions: QuestionsForCareTaker = QuestionsForCareTaker()
  
   
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var questionText: UITextField!
    
    @IBOutlet weak var answer1Text: UITextField!
    
    
    @IBOutlet weak var Answer2Text: UITextField!
    
    @IBOutlet weak var Answer3Text: UITextField!
    
    @IBOutlet weak var Answer4Text: UITextField!
    
    @IBOutlet weak var wrightAnswerSelector: UISegmentedControl!
    
    
  
    // MARK: - Actions
    
    @IBAction func addQuestionAction(_ sender: Any) {
        
        // проверим что все поля заполнены и не будем продолжать если нет
        
        if questionText.text == "" {
            alerts!.CreateEmptyQuestionAlert()
            return
        }
        
        if answer1Text.text == "" {
            alerts!.CreateEmptyAnswerAlert(answerPosition: 0)
            return
        }
        
        if Answer2Text.text == "" {
            alerts!.CreateEmptyAnswerAlert(answerPosition: 1)
            return
        }
        if Answer3Text.text == "" {
            alerts!.CreateEmptyAnswerAlert(answerPosition: 2)
            return
        }
        
        if Answer4Text.text == "" {
            alerts!.CreateEmptyAnswerAlert(answerPosition: 3)
            return
        }
        
        // добавить вопрос и ответы к StaticQA
        
        // получим последний id из staticQA. Для простоты считаем, что хотя бы один вопрос там есть
        guard let lastId = qa.questions.last?.id else { return }
        let nextId = lastId + 1
        // создадим следующий вопрос
        let question = Questions(id: nextId, text: questionText.text!)
        qa.questions.append(question)
       
        
        // ответ 1
        let answer = Answers(questionId: nextId, id: 0, text:  answer1Text.text!, bingo: getBingoFromSelector(id:0))
        qa.answers.append(answer)
       
        // ответ 2
        let answer1 = Answers(questionId: nextId, id: 1, text:  Answer2Text.text!, bingo: getBingoFromSelector(id:1))
        qa.answers.append(answer1)
     
        
        // ответ 3
        let answer2 = Answers(questionId: nextId, id: 2, text:  Answer3Text.text!, bingo: getBingoFromSelector(id:2))
        qa.answers.append(answer2)
     
        // ответ 4
        let answer3 = Answers(questionId: nextId, id: 3, text:  Answer4Text.text!, bingo: getBingoFromSelector(id:3))
        qa.answers.append(answer3)
        
        
        
      
        
        // добавить в memento QuestionsCareTaker созданный вопрос с ответами
        questions.questions = qa.questions
        questions.answers = qa.answers
        
        Game.shared.setQuestions(questions)
    
        
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.alerts = Alerts(view: self)
        // здесь получаем текущие вопросы
        

        // Do any additional setup after loading the view.
    }
    
   
    // MARK: - Private Functions
    
    private func getBingoFromSelector(id: Int) -> Bool {
        // если id совпадает с selectedSegmentIndex, то true
        wrightAnswerSelector.selectedSegmentIndex == id ? true : false
    }


    

  

}
