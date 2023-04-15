//Created by chizztectep on 15.04.2023 

import Foundation

class TestModel {
    var tasks: [Tasks] = []
    
    func createTestTasks() {
       
        let task1: Tasks = Tasks("task1",nil)
        let task2: Tasks = Tasks("task2",nil)
        let task3: Tasks = Tasks("task3",nil)
        
        let task11: Tasks = Tasks("task11","task1")
        let task12: Tasks = Tasks("task12","task1")
        
        task1.addTask(task11)
        task1.addTask(task12)
        
        let task111: Tasks = Tasks("task111","task11")
        task11.addTask(task111)
        
        let task121: Tasks = Tasks("task121","task12")
        task12.addTask(task121)
        
        let task21:Tasks = Tasks("task21","task2")
        task2.addTask(task21)
        
        let task31: Tasks = Tasks("task31","task3")
        let task32: Tasks = Tasks("task32","task3")
        
        task3.addTask(task31)
        task3.addTask(task32)
        
        self.tasks.append(task1)
        self.tasks.append(task2)
        self.tasks.append(task3)
        
        
        
        
        
    }
}
