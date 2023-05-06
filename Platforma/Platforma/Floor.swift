//Created by chizztectep on 06.05.2023 

import Foundation

class Floor {
    var victims_on_floor:[Victim] = []
    var table: Table
    var index: Int
    
    init(index:Int, table: Table) {
        // добавим observer на  table?.currentFloor
        self.table = table
        self.index = index
        table.currentFloor.addObserver(self, options: [.new]) { floor, _ in
            
            if floor == index {
                
                //print("table on \(index) floor")
                // обработка действий victim
                for victim in self.victims_on_floor {
                    // 
                    
                    
                }
                
            }
        }
    }
    
}
