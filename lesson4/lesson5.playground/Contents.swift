import UIKit

enum CarMenu {
    case engade
    case windowOpen
    case move(movingSpace:Int)
    case new
}

enum SportCarMenu {
    case nitro
    case new
}

enum TruncCarMenu {
    case activate44
    case new
}

protocol Car {
    var mark: String {get set}
    var year: Int {get set}
    var space: Int {get set}
    var engaged: Bool {get set}
    var windowOpen: Bool {get set}
    var spaceFilled: Int {get set}
    var carMenu: CarMenu {get set}
    
}

class SportCar: Car {
    var mark: String
    var year: Int
    var space: Int
    var engaged: Bool = false
    var windowOpen: Bool = false
    var spaceFilled: Int = 0
    var carMenu: CarMenu = .new
    var sportCarMenu: SportCarMenu = .new
    
    var nitro_on: Bool = false {
        didSet {
            print("nitro_on \(nitro_on)")
        }
    }
    
    func useSportCarMenu(carFunc: SportCarMenu) {
        switch carFunc  {
        case .nitro: nitro_on.toggle()
        default: break
        }
    }
    
    init(mark: String, year: Int, space: Int){
        self.mark = mark
        self.year = year
        self.space = space
    }
    
}

class TrunkCar : Car {
    var mark: String
    var year: Int
    var space: Int
    var engaged: Bool = false
    var windowOpen: Bool = false
    var spaceFilled: Int = 0
    var carMenu: CarMenu = .new
    var trunkCarMenu: TruncCarMenu = .new
    
    var activate44_on: Bool = false {
        didSet {
            print("activate44 \(activate44_on)")
        }
    }
    init(mark: String, year: Int, space: Int){
        self.mark = mark
        self.year = year
        self.space = space
    }
    
    func useTrunkCarMenu(carFunc: TruncCarMenu) {
        switch carFunc  {
        case .activate44: activate44_on.toggle()
        default: break
        }
    }
}



extension Car {
    mutating func useMenu(carFunc:CarMenu) {
        switch carFunc  {
        case .engade:
            self.engaged.toggle()
            self.engaged ? print("двигатель запущен") : print("двигатель остановлен")
        case .windowOpen:
            self.windowOpen.toggle()
            self.windowOpen ? print("окна открыты") : print("окна закрыты")
        case .move(let movedSpace):
            let new_space = self.spaceFilled + movedSpace
            if new_space > self.space {
                self.spaceFilled = self.space
                print("Багажник переполнен, не влезает \(new_space - self.space)")
                break
            }
            if new_space < 0 {
                self.spaceFilled = 0
                print("в багажнике больше ничего нет")
                break
            }
            self.spaceFilled += movedSpace
            print("успешно, в багажнике заполнено \(self.spaceFilled) из \(self.space)")
            
        default: break
        }
        }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Цистерна марки \(mark), год выпуска \(year)"
    }
}

extension SportCar: CustomStringConvertible {
        var description: String {
            return "Машина марки \(mark), год выпуска \(year)"
        }
}

var trc:TrunkCar = TrunkCar(mark: "hhh", year: 2000, space: 1000)
print(trc)
var trc2:TrunkCar = TrunkCar(mark: "ggg", year: 2001, space: 2000)
print(trc2)
var spc:SportCar = SportCar(mark: "sport aaa", year: 1999, space: 100)
var spc2:SportCar = SportCar(mark: "sport bbb", year: 2022, space: 200)
print(spc)
print(spc2)

trc.useMenu(carFunc: .engade)
trc.useTrunkCarMenu(carFunc: .activate44)
spc.useSportCarMenu(carFunc: .nitro)
spc.useMenu(carFunc: .windowOpen)
    

