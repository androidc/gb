//Created by chizztectep on 15.04.2023

// v.1.0 - lesson5hw

import UIKit

class AddTaskViewController: UIViewController {
    
    
    
    // MARK: - Outlets

    @IBOutlet weak var parentTask: UITextField!
    
    @IBOutlet weak var subTask: UITextField!
    
    // MARK: - Actions
    
    @IBAction func addTaskAction(_ sender: Any) {
        
         // это можно убрать, так как мы автоматически заполняем родителя и не даем его менять
//        if CurrentLevel.shared.level != 0 {
//        guard parentTask.text != "" else {
//            print("не указан текст родительской задачи")
//            return
//        } }
        
        guard subTask.text != "" else {
            print("не указан текст подзадачи")
            return
        }
        
        if CurrentLevel.shared.level == 0 {
            
             addTaskToCurrentLevel(subTask.text!,nil)

        } else {
           addTaskToCurrentLevel(subTask.text!,parentTask.text!)

        }
 
        // вызываем tableView.reload 
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "load"), object: nil)
        self.dismiss(animated: false)
    }
    
    
    // MARK: - main
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // если есть подзадачи, у которых есть родитель
        if CurrentLevel.shared.currentTasks.count > 0 ,let parent = CurrentLevel.shared.currentTasks[0].parent {
            parentTask.text = parent
        } // иначе мы либо в корне либо в листе
        else {
            // для отладки
            CurrentLevel.shared.description()
            
            // если мы находимся в корне
            if CurrentLevel.shared.currentTasksInStack.count == 1 {
                parentTask.text = "Root"
            } // иначе мы в листе
             else {
                
                parentTask.text = CurrentLevel.shared.currentTasksInStack[1][CurrentLevel.shared.selectedIndexPath].name
            }
    
            
        }
        
    }
    
    // MARK: - Private Func
    
    
    private func addTaskToCurrentLevel(_ subTask: String,_ parent: String?) {
        let newTask = Tasks(subTask, parent)
        CurrentLevel.shared.currentTasks.append(newTask)
        // обновляем таску в стеке
        CurrentLevel.shared.pop()
        CurrentLevel.shared.push(CurrentLevel.shared.currentTasks)
    }


}
