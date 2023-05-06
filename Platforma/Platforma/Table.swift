//Created by chizztectep on 06.05.2023 

import Foundation

class Table {
    var currentFoodValue: Int
    var currentFloor = Observable<Int>(0)
    
    init(currentFoodValue:Int) {
        self.currentFoodValue = currentFoodValue
    }
}
