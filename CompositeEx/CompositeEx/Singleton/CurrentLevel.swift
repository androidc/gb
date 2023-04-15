//Created by chizztectep on 15.04.2023 

import Foundation

class CurrentLevel {
    static let shared = CurrentLevel()
    
    var level: Int = 0
    var currentTasks:[Tasks] = []
    var currentTasksInStack:[[Tasks]] = []
    
    func description() {
        currentTasks.forEach { task in
            print(task.name)
        }
    }
    
     func pop() -> [Tasks] {
           return currentTasksInStack.removeFirst()
       }
    
  
    
     func push(_ element: [Tasks]) {
         currentTasksInStack.insert(element, at: 0)
       }
    
    func peek() -> [Tasks]? {
        guard let topElement = currentTasksInStack.first else { return nil }
        return topElement
    }
    
  
  
 
}
