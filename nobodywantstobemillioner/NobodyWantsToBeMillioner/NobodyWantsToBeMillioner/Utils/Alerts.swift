//Created by chizztectep on 01.04.2023
// v.1.0.1 - hw pattern l2 strategy, facade, observer, builder

import Foundation
import UIKit

class Alerts {
    var view:UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func CreateEmptyQuestionAlert() {
        let alert = UIAlertController(title: "Ошибка!", message: "Текст вопроса не может быть пустым", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Упс", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    func CreateEmptyAnswerAlert(answerPosition: Int) {
        let alert = UIAlertController(title: "Ошибка!", message: "Текст ответа \(answerPosition + 1) не может быть пустым", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Упс", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    
    func CreateAlert() {
        let alert = UIAlertController(title: "Неверный ответ", message: "Вы проиграли", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "в следующий раз повезет", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    func CreateEndAlert() {
        let alert = UIAlertController(title: "Победа!", message: "Вы выиграли миллион", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "а где деньги?!", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
}
