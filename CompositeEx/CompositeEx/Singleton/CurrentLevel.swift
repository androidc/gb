//Created by chizztectep on 15.04.2023

// v.1.0 - lesson5hw

import Foundation

class CurrentLevel {
    static let shared = CurrentLevel()
    
    var level: Int = 0
    // текущее состояние
    var currentTasks:[Tasks] = []
    // Стек состояний
    var currentTasksInStack:[[Tasks]] = []
    
    var selectedIndexPath: Int = 0
    
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
