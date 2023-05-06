//Created by chizztectep on 06.05.2023 

import Foundation

class Platforma {
    /// жители в платформе
    var victims:[Victim] = []
    /// стол с едой
    let table:Table
    /// количество этажей
    let floorCount: Int
    
    var dayCounter: Int = 0
    
    var floors:[Floor] = []
    let dayToRotate: Int = 30
    
    
    let queue = DispatchQueue.global(qos: .utility)
    
    init(victims: [Victim], floorCount: Int) {
        self.victims = victims
        self.table = Table(currentFoodValue: floorCount * 2)
        self.floorCount = floorCount
        for i in 1...floorCount {
            self.floors.append(Floor(index:i, table: self.table))
        }
       
    }
    
    func settleVictims() {
        var shuffleVictims:[Victim] = victims.shuffled()
        
        for floor in floors {
            if let victim = shuffleVictims.popLast() {
                floor.victims_on_floor.append(victim)
            }
            if let victim = shuffleVictims.popLast() {
                floor.victims_on_floor.append(victim)
            }
            
        }
    }
    
    
    
    func tableLifeCycle() {
        queue.async {
            while true {
               
                print("table move. floor is \(self.table.currentFloor.value)")
//                if self.table.currentFloor.value > 0 && self.table.currentFloor.value <= 5 {
//                    for victim in self.floors[self.table.currentFloor.value - 1].victims_on_floor {
//                        print("here is \(victim.name)")
//                    }
//
//                }
               
                // стол на 0 этаже, люди просыпаются
                if self.table.currentFloor.value == 0 {
                   // определяем кто проснулся первым
                   // проходим по всем этажам
                    for floor in self.floors {
                        // выбираем всех жителей на этаже в статусе .live и берем из них случайного
                       let firstWakeUpVictim = floor.victims_on_floor.filter{$0.status == .live}.randomElement()
                        // обновляем в таблице victims этого victim
                        if firstWakeUpVictim != nil{
                            firstWakeUpVictim?.firstWakeUp = true
//                            print(self.victims.filter{$0.id
//                                == firstWakeUpVictim!.id}.first?.firstWakeUp)
                            firstWakeUpVictim?.appendLog(message: "\(firstWakeUpVictim!.name) проснулся первым",floor: floor.index, toPrint: false)
                        }
                        
                      
                        
                        // увеличиваем всем жителям на этаже +1 к прожитым дням
                        for victim in floor.victims_on_floor {
                            if victim.status != .dead {victim.dayZ += 1}
                            
//                            self.victims.filter{$0.id
//                                == victim.id}.first?.dayZ += 1
                        }
                        
                        
                    }
                }
                
                // стол на этаже, люди едят
                if self.table.currentFloor.value > 0 && self.table.currentFloor.value <= self.floorCount {
                    //выбираем этаж
                    let floor = self.floors[self.table.currentFloor.value-1]
                    // выбираем кто первый ест
                    let eatOrder = floor.victims_on_floor.filter{$0.status == .live}.shuffled()
                    for victim in eatOrder {
                        let minusFood:Int =  self.victims.filter{$0.id == victim.id}.first?.eat(table: self.table, floor: floor) ?? 0
                            self.table.currentFoodValue -= minusFood
//                        switch victim.status {
//                        case .dead:
//                            victim.deadTimePass += 1
//                            victim.appendLog(message: "мертв, не может есть", floor: floor.index, toPrint: false)
//                        case .live:
//                            let minusFood:Int =  self.victims.filter{$0.id == victim.id}.first?.eat(table: self.table, floor: floor) ?? 0
//                            self.table.currentFoodValue -= minusFood
//
//
//                        case .immobilized:
//                            victim.appendLog(message: "обездвижен, не может есть", floor: floor.index, toPrint: false)
//                        }
                        
                    }
                    
                    
                }
                
                
                self.table.currentFloor.value+=1
                
                if self.table.currentFloor.value > self.floorCount {
                    sleep(1)
                    self.table.currentFloor.value = 0
                    // все засыпают
                    for victim in self.victims {
                        victim.firstWakeUp = false
                    }
                    
                    // на каждый n (10 по умолчанию) день происходит рокировка
                    if (self.dayCounter % self.dayToRotate == 0) && (self.dayCounter > 0) {
                       
                        // без очистки
                        self.rotate(clearDead: false)
                        
//                        // с очисткой от трупов
//                        if self.dayCounter % (self.dayToRotate * 2) == 0 {
//                            self.rotate(clearDead: true)
//                        }else {
//                            self.rotate(clearDead: false)
//                        }
                        
                    }
                    
                    
                    // движуха
                    self.victimsAction()
                    
                    
                    // наполняем тарелку
                    self.table.currentFoodValue = self.floorCount * 2
                    
                    // увеличиваем счетчик дней
                    self.dayCounter += 1
                    
                    
                }
               
               
            }
        }
    }
    
    // MARK: - Private functions

    private func rotate(clearDead: Bool) {
        // самый простой способ - сделать shuffle этажей и ...
        let floors_shuffled = floors.shuffled()
        
        var floors_new:[Floor] = []
        for (index,floor) in floors_shuffled.enumerated() {
            // добавляем на новые этажи живых. мертвых надо оставить на тех этажах, где они лежали
            // создаем новый этаж
            let floor_new = Floor(index: index+1, table: self.table)
            // берем всех живых с рандомно выбранного этажа
            let liveVictims = floor.victims_on_floor.filter{$0.status == .live || $0.status == .immobilized}
            // добавляем их на этаж
            floor_new.victims_on_floor = liveVictims
            floors_new.append(floor_new)
        }
        
        // сортировать по парам
        var ind: Int = 0
        
        while ind < floors_new.count {
            // получаем количество живых на текущем этаже
            let liveVictims = floors_new[ind].victims_on_floor.filter{$0.status == .live || $0.status == .immobilized}
            if liveVictims.count == 1 {
                // запоминаем индекс этажа
                let memoryIndex = ind
                // доходим до этажа где есть такой же один или до конца
                
                ind += 1
           
                while ind < floors_new.count && floors_new[ind].victims_on_floor.filter{$0.status == .live || $0.status == .immobilized}.count != 1  {
                    ind += 1
                }
                
                if ind < floors_new.count {
                    // здесь будет индекс следующего этажа с одним живым
                    let liveVictim = floors_new[ind].victims_on_floor.first
                    
                    floors_new[memoryIndex].victims_on_floor.append(liveVictim!)
                    floors_new[ind].victims_on_floor.removeAll()
                }
                
                ind += 1
                
            } else {
                ind += 1
            }
        }
       
       
        
        
        // добавим мертвых на этажи где они были
        if !clearDead {
        for (index,floor) in floors_shuffled.enumerated() {
            // выбираем мертвых
            let deadVictims = floor.victims_on_floor.filter{$0.status == .dead}
            for dead in deadVictims {
                floors_new[floor.index-1].victims_on_floor.append(dead)
            }
        }
        }
        
        let names = Names()
        // добавляем людей в комнаты, где остался один человек либо не осталось совсем
        for (index,floor) in floors_new.enumerated() {
            // получаем количество живых на текущем этаже
            let liveVictims = floor.victims_on_floor.filter{$0.status == .live || $0.status == .immobilized}
            if liveVictims.count == 1 {
                let victim_new = Victim(name: names.names.randomElement()!)
                floors_new[index].victims_on_floor.append(victim_new)
                self.victims.append(victim_new)
            }
            
            if liveVictims == nil || liveVictims.count == 0 {
                let victim_new = Victim(name: names.names.randomElement()!)
                floors_new[index].victims_on_floor.append(victim_new)
                self.victims.append(victim_new)
                let victim_new1 = Victim(name: names.names.randomElement()!)
                floors_new[index].victims_on_floor.append(victim_new1)
                self.victims.append(victim_new1)
                
            }
        }
        
    
        floors = floors_new
       
    }
    
    private func victimsAction() {
        let victimsActionOrder:[Victim] = victims.shuffled()
        for victim in victimsActionOrder {
            if victim.status == .dead {
                victim.deadTimePass += 1
            } else {
                // выясняем на каком этаже находится victim
                let floor = floors.filter { floor in
                    floor.victims_on_floor.contains { $0.id == victim.id}
                }.first
                
                if victim.hungry >= 15 {
                    // житель раздражен
                    // выясняем с кем он в комнате из живых
                    let victims_on_floor = floor?.victims_on_floor.filter{$0.status == .live}
                    if victims_on_floor?.count == 1 {
                        // если он один в комнате, то при достижении hungry = 20 начинается спускаться по этажам
                        // TODO
                    } else {
                        // выбираем кто из них проиграл в схватке
                        let victims_on_floor_shuffled = victims_on_floor?.shuffled()
                        let looser = victims_on_floor_shuffled!.first
                        looser?.status = .dead
                        looser?.appendLog(message: "умер от руки \(victims_on_floor_shuffled![1].name) ", floor: floor?.index ?? 999, toPrint: false)
                    }
                  
                    
                    
                  
                } else {
                    // житель сыт и не ссыт и занимается своими делами
                    victim.appendLog(message: "день прошел без происшествий", floor: floor?.index ?? 999, toPrint: false)
                }
                
              
                
                
            }
            
           
            
            
            
        }
        
    }
    
    
}
