//Created by chizztectep on 25.03.2023 

import UIKit




class GameScreenViewController: UIViewController {
    
  
   
    
    
    // инициализируем базу вопросов и ответов
    let staticQA = StaticQA()
    
  
    
    // MARK: - Outlets
    
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var Answer1Text: UIButton!
    
    @IBOutlet weak var Answer2Text: UIButton!
    
    
    @IBOutlet weak var Answer3Text: UIButton!
    
    
    @IBOutlet weak var Answer4Text: UIButton!
    
    @IBAction func Answer1Action(_ sender: Any) {
       // print(Answer1Text.titleLabel?.text)

       obrabotkaOtveta(atIndex: 0)
    }
    
    @IBAction func Answer2Actiion(_ sender: Any) {
        obrabotkaOtveta(atIndex: 1)

    }
    @IBAction func Answer3Action(_ sender: Any) {
        obrabotkaOtveta(atIndex: 2)
    }
    
    @IBAction func Answer4Action(_ sender: Any) {
        obrabotkaOtveta(atIndex: 3)
    }
    
    
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // создаем сессию, начальная ставка = 100 , id вопроса = 1
        let gameSession = GameSession()
        
        Game.shared.gameSession = gameSession
        
        // передаем в GameSession через делегат QA
        Game.shared.gameSession?.qa = staticQA
        
      
        
//
      //  Game.shared.gameSession?.questionsCount = staticQA.questions.count
        
//        gameDelegate?.setupQuestionCount(withResult: staticQA.questions.count)
//
        // устанавливаем первый вопрос
        setQuestion(question: staticQA.questions[0], answers: staticQA.getAnswersByQuestionId(questionId: 0))
        
        
        
        // проверка работы метода getAnswersByQuestionId
       // print(staticQA.getAnswersByQuestionId(questionId: 1))

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - private functions
    private func setQuestion(question: Questions, answers: [Answers]) {
        self.QuestionLabel.text = question.text
//        self.Answer1Text.titleLabel?.text = answers[0].text
//        self.Answer2Text.titleLabel?.text = answers[1].text
//        self.Answer3Text.titleLabel?.text = answers[2].text
//        self.Answer4Text.titleLabel?.text = answers[3].text
        self.Answer1Text.setTitle(answers[0].text, for: .normal)
        self.Answer2Text.setTitle(answers[1].text, for: .normal)
        self.Answer3Text.setTitle(answers[2].text, for: .normal)
        self.Answer4Text.setTitle(answers[3].text, for: .normal)
    }
    
    private func CreateAlert() {
        let alert = UIAlertController(title: "Неверный ответ", message: "Вы проиграли", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "в следующий раз повезет", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func CreateEndAlert() {
        let alert = UIAlertController(title: "Победа!", message: "Вы выиграли миллион", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "а где деньги?!", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func restartGame() {
        
        // возвращаем текущий gameSession в начальные значения и обновлям вопрос
       // self.gameSession.questionId = 0
        Game.shared.gameSession?.questionId = 0
        
        //self.gameSession.currentValue = 100
        Game.shared.gameSession?.currentValue = 100
        // устанавливаем первый вопрос
        setQuestion(question: staticQA.questions[0], answers: staticQA.getAnswersByQuestionId(questionId: 0))
        
    }
    
    private func obrabotkaOtveta(atIndex index: Int) {
       // let questionId = self.gameSession.questionId
        let questionId = Game.shared.gameSession?.questionId ?? 0
        let answers = self.staticQA.getAnswersByQuestionId(questionId: questionId)
         // если выбрали неправильный ответ, то выдаем алерт
         if !answers[index].bingo {
             CreateAlert()
             restartGame()
          }    else {
              // если все ок, то увеличиваем ставку и меняем вопросы и увеличиваем номер вопроса на 1
             //self.gameSession.currentValue += 100
              Game.shared.gameSession?.currentValue += 100
              
             // self.gameSession.questionId += 1
              Game.shared.gameSession?.questionId += 1
              
              let questionId = Game.shared.gameSession?.questionId ?? 0
              
              if questionId < self.staticQA.questions.count {
                  setQuestion(question: staticQA.questions[questionId], answers: staticQA.getAnswersByQuestionId(questionId: questionId))
              } else {
                  CreateEndAlert()
                  restartGame()
              }
          }
    }
    
    
    

}





    



    



    

