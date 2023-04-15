//Created by chizztectep on 15.04.2023 

import Foundation

protocol Task {
    var name: String {get}
    var parent: String? {get}
}


class Tasks: Task {
    
    var name: String
    var parent: String?
    var tasks:[Tasks] = []
    
    init(_ name: String, _ parent: String?){
        self.name = name
        self.parent = parent
    }
    
    func addTask(_ task: Tasks) {
        tasks.append(task)
    }
}
