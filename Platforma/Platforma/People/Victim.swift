//Created by chizztectep on 06.05.2023 

import Foundation

enum Status {
    case live
    case dead
    case immobilized
    
    func showStatus() -> String {
        switch self {
        case .live:
           return "живой"
        case .dead:
           return "мертвый"
        case .immobilized:
          return "обездвиженный"
        }
    }
}

class Victim {
    // уникальный идентификатор 
    var id = UUID().uuidString
    /// голод. при hungry = 10 повышается агрессия. после приема пищи hungry уменьшается на процент насыщения
    var hungry:Int = 0
    /// количество прожитых дней на платформе
    var dayZ:Int = 0
    /// true , если проснулся первым
    var firstWakeUp: Bool = false
    /// здоровье
    var health:Int = 100
    /// статус - живой, мертвый, обездвиженный
    var status:Status = .live
    var bigAppetite: Bool = false
    var deadTimePass: Int = 0
   
    var logs:[Log] = []
    
    /// фио
    var name: String
    
    
    init(name: String){
        self.name = name
    }
    
    func appendLog(message: String,floor: Int, toPrint: Bool) {
        logs.append(Log(day: dayZ,floor: floor , status: self.status,  message: message, level: .Info,hungry: self.hungry))
        if toPrint {print(message)}
    }
    
    /**
         житель съедает в зависимости от аппетита 1-3 порции или 4-6
         - Parameter table: - стол с едой
         - Returns:  количество уничтоженной еды
     */
    func eat(table: Table, floor: Floor) -> Int {
        let food = table.currentFoodValue
        // если у него голод = 20, то умирает
        if hungry>=20 {
            status = .dead
            appendLog(message: "умер от голода", floor: table.currentFloor.value, toPrint: false)
            // если убрать здесь return , то появятся зомби
            // и баги..
            return 0
        }
        
      
        
      
  
        
        let wantsTo = wantsToEat()
        appendLog(message: "\(name) хочет съесть \(wantsTo) порций", floor: table.currentFloor.value,toPrint: false)
        if food == 0 {
            // логируем, что еды нет
            appendLog(message: "еды нет. \(name) голодает",floor: table.currentFloor.value,toPrint: false)
            // ищем свежий труп
            let freshDeadBody = floor.victims_on_floor.filter{$0.status == .dead && $0.deadTimePass <= 3}.first
            if freshDeadBody != nil {
                // логируем, что нашли труп
                appendLog(message: "едим товарища \(freshDeadBody!.name)", floor: floor.index, toPrint: true)
                hungry-=5
                if hungry < 0 {hungry = 0}
            } else {
                // увеличиваем голод на 1
                hungry += 1
            }
            
            return 0}
        if wantsTo <= food {
            // если еды достаточно, то полностью утоляем голод и возвращаем число съеденных порций
            hungry = 0
            // логируем что вкусно поели
            appendLog(message: "еды полно \(name) вкусно поел(а)",floor: table.currentFloor.value,toPrint: false)
            return wantsTo
        } else {
            // если еды недостаточно, то утоляем голод на количество дней = количество съеденных на столе порций и возвращаем количество этих порций
            hungry -= food
            if hungry<0 {hungry = 0}
            // логируем что в животе урчит
            appendLog(message: "у \(name) урчит в животе",floor: table.currentFloor.value,toPrint: false)
            return food
        }
        
      
        
    }
    

    
    private func wantsToEat() -> Int {
        if !bigAppetite {
            return Int.random(in: 1..<4)
        } else {
            return Int.random(in: 3..<7)
        }
    }
   
}
