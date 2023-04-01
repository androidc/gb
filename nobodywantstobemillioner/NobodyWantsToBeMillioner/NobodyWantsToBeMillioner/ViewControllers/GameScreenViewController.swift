//Created by chizztectep on 25.03.2023 

import UIKit

// v.1.0.0


class GameScreenViewController: UIViewController {
    
  
    weak var gameSessionDelegate: GameSessionDelegate?
    
    private var alerts: Alerts?
    
    // глобальная переменная для прохода по qa.questions
    var qPosition:Int = 0
    
    
    // MARK: - Strategy
    private var qaStrategy:ChoosenStrategy = .randomStrategy
    
    // инициализируем базу вопросов и ответов
   // let staticQA = StaticQA()
    
    var qa: StaticQA?
    
  
    
    // MARK: - Outlets
    
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var Answer1Text: UIButton!
    
    @IBOutlet weak var Answer2Text: UIButton!
    
    
    @IBOutlet weak var Answer3Text: UIButton!
    
    
    @IBOutlet weak var Answer4Text: UIButton!
    
    @IBOutlet weak var questionNumberText: UILabel!
    
    @IBOutlet weak var percentText: UILabel!
    
    // MARK: - Actions
    
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
        
        // инициализация класса с алертами
        self.alerts = Alerts(view: self)
        
        // создаем сессию, начальная ставка = 100 , id вопроса = 1
        let gameSession = GameSession()
        
        Game.shared.gameSession = gameSession
        
        // добавим Observer к questionPosition
        gameSession.questionPosition.addObserver(self, options: [.new, .initial]) { [weak self] (questionPosition, _) in
            
            self?.questionNumberText.text = "Номер вопроса: \(questionPosition)"
            self?.percentText.text = "Процент выполнения: \(String(describing: gameSession.winPercent() ?? 0))"
            
        }
        
      
        //Game.shared.gameSession?.qa = staticQA
        
        gameSessionDelegate = Game.shared.gameSession
        
        // в соответсвии от выбранной стратегии возвращаем qa
        
        // берем qaStrategy из синглтона. по умолчанию там .staticStrategy
        
        qaStrategy = Game.shared.choosenStrategy
        
       // qaStrategy = Game.shared.gameSession?.choosenStrategy ?? .staticStrategy
        
        
    
        self.qa = getQaStrategy(strategy: qaStrategy)
        guard let qa = self.qa else {return}
        gameSessionDelegate?.setQA(qa: qa)
        
        gameSessionDelegate?.setQuestionPosition(id: 0)
        
        
        
        
//
      //  Game.shared.gameSession?.questionsCount = staticQA.questions.count
        
//        gameDelegate?.setupQuestionCount(withResult: staticQA.questions.count)
//
        // устанавливаем первый вопрос
        setQuestion(question: qa.questions[0])
        
        
        
        // проверка работы метода getAnswersByQuestionId
       // print(staticQA.getAnswersByQuestionId(questionId: 1))

        // Do any additional setup after loading the view.
    }
    
   
   
    // MARK: - private functions
    private func setQuestion(question: Questions) {
        self.QuestionLabel.text = question.text
        guard let answers = self.qa?.getAnswersByQuestionId(questionId: question.id) else {return}
        
//        self.Answer1Text.titleLabel?.text = answers[0].text
//        self.Answer2Text.titleLabel?.text = answers[1].text
//        self.Answer3Text.titleLabel?.text = answers[2].text
//        self.Answer4Text.titleLabel?.text = answers[3].text
        self.Answer1Text.setTitle(answers[0].text, for: .normal)
        self.Answer2Text.setTitle(answers[1].text, for: .normal)
        self.Answer3Text.setTitle(answers[2].text, for: .normal)
        self.Answer4Text.setTitle(answers[3].text, for: .normal)
    }
    
   
    
    private func restartGame() {
        
        // сохраняем рекорд в Game
        let score = gameSessionDelegate?.getQuestionPosition()
        let record = Record(date: Date(), score: score ?? 0)
        Game.shared.addRecord(record)
        
        
        // возвращаем текущий gameSession в начальные значения и обновлям вопрос
      
        //gameSessionDelegate?.setQuestionId(id: 0)
        
        guard let qa = self.qa else {return}
        gameSessionDelegate?.setQuestionPosition(id: 0)
  
        gameSessionDelegate?.setCurrentValue(value: 100)
        // устанавливаем первый вопрос
       
        setQuestion(question: qa.questions[0])
        
    }
    
    private func obrabotkaOtveta(atIndex index: Int) {
       // let questionId = self.gameSession.questionId
        // здесь будет храниться текущая позиция вопроса
        var questionId = Game.shared.gameSession?.questionPosition.value ?? 0
        guard let qa = self.qa else {return}
        let answers = qa.getAnswersByQuestionId(questionId: qa.questions[questionId].id)
         // если выбрали неправильный ответ, то выдаем алерт
         if !answers[index].bingo {
             alerts!.CreateAlert()
             restartGame()
          }    else {
              // если все ок, то увеличиваем ставку и меняем вопросы и увеличиваем номер вопроса на 1
             //self.gameSession.currentValue += 100
              Game.shared.gameSession?.currentValue += 100
              
             // self.gameSession.questionId += 1
              questionId += 1
              self.gameSessionDelegate?.setQuestionPosition(id: questionId)
              
            
              
             
              if questionId < qa.questions.count {
                  let qID = qa.questions[questionId].id
                  setQuestion(question: qa.questions[questionId])
              } else {
                  alerts!.CreateEndAlert()
                  restartGame()
              }
          }
    }
    
    private func getQaStrategy (strategy: ChoosenStrategy) -> StaticQA {
        switch strategy {
        case .staticStrategy:
            let strategy = StaticQAStrategy()
            return strategy.setQA()
        case .randomStrategy:
            let strategy = RandomQAStrategy()
            return strategy.setQA()
        }
    }
    

    
    

}





    



    



    

