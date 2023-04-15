//Created by chizztectep on 15.04.2023 

import UIKit

class AddTaskViewController: UIViewController {
    
    
    
    // MARK: - Outlets

    @IBOutlet weak var parentTask: UITextField!
    
    @IBOutlet weak var subTask: UITextField!
    
    // MARK: - Actions
    
    @IBAction func addTaskAction(_ sender: Any) {
        
        if CurrentLevel.shared.level != 0 {
        guard parentTask.text != "" else {
            print("не указан текст родительской задачи")
            return
        } }
        
        guard subTask.text != "" else {
            print("не указан текст подзадачи")
            return
        }
        
        if CurrentLevel.shared.level == 0 {
            
             addTaskToCurrentLevel(subTask.text!,nil)
//            let newTask = Tasks(subTask.text!, nil)
//            CurrentLevel.shared.currentTasks.append(newTask)
//            print(CurrentLevel.shared.currentTasks.description)
//            CurrentLevel.shared.pop()
//            CurrentLevel.shared.push(CurrentLevel.shared.currentTasks)
//            print(CurrentLevel.shared.currentTasks.description)
        } else {
           addTaskToCurrentLevel(subTask.text!,parentTask.text!)
//            let newTask = Tasks(subTask.text!, parentTask.text!)
//            CurrentLevel.shared.currentTasks.append(newTask)
//            CurrentLevel.shared.pop()
//            CurrentLevel.shared.push(CurrentLevel.shared.currentTasks)
//            print(CurrentLevel.shared.currentTasks.description)
        }
        
       
        // вызываем tableView.reload 
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "load"), object: nil)
        self.dismiss(animated: false)
    }
    
    
    // MARK: - main
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CurrentLevel.shared.currentTasks.count > 0 ,let parent = CurrentLevel.shared.currentTasks[0].parent {
            parentTask.text = parent
        } else {
            CurrentLevel.shared.description()
            if CurrentLevel.shared.currentTasksInStack.count == 1 {
                parentTask.text = "Root"
            } else {
                
                parentTask.text = CurrentLevel.shared.currentTasksInStack[1][CurrentLevel.shared.selectedIndexPath].name
            }
            
         //   parentTask.text = CurrentLevel.shared.currentTasks[0].name
            
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
