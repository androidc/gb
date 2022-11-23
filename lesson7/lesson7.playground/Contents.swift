import UIKit

/* 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.*/

enum CarMenu {
    case engade
    case windowOpen
    case move(movingSpace:Int)
    case new
}

enum CarError: Error {
    case engineBroken
    case windowBroken
    case wrongCode
}

enum SportCarMenu {
    case nitro
    case new
}

enum TruncCarMenu {
    case activate44
    case new
}

class ExternalConditions {
    var engineTemperature: Int
    var externalTemperature: Int
    
    init(engineTemperature: Int, externalTemperature: Int) {
        self.engineTemperature = engineTemperature
        self.externalTemperature = externalTemperature
    }
}

class Car {
    private var mark: String
    private var year: Int
    private var space: Int
    private var engaged: Bool = false
    private var windowOpen: Bool = false
    private var spaceFilled: Int = 0
    private var CarMenu: CarMenu = .new
    
    init(mark: String, year: Int, space: Int){
        self.mark = mark
        self.year = year
        self.space = space
    }
    
    func useCode(_ code: Int) throws -> Bool {
        switch code {
        case 0: "print signal off"
                 return true
        case 1: "print signal on"
                 return true
        default: throw CarError.wrongCode
        }
    }
    
    func useMenu(carFunc: CarMenu, extC: ExternalConditions ) throws {
        switch carFunc  {
        case .engade:
            guard extC.engineTemperature < 90 else {
                throw CarError.engineBroken
            }
            self.engaged = !self.engaged
            self.engaged ? print("двигатель запущен") : print("двигатель остановлен")
        case .windowOpen:
            guard extC.externalTemperature > -20 else {
                throw CarError.windowBroken
            }
            self.windowOpen = !self.windowOpen
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

class SportCar: Car {
    var sportCarMenu: SportCarMenu
    var nitro_on: Bool = false {
        didSet {
            print("nitro_on \(nitro_on)")
        }
    }
    
    override init(mark: String, year: Int, space: Int) {
        self.sportCarMenu = .new
        super.init(mark: mark, year: year, space: space)
    }
    
    func useSportCarMenu(carFunc: SportCarMenu) {
        switch carFunc  {
        case .nitro: nitro_on.toggle()
        default: break
        }
    }
    
}

class TrunkCar: Car {
    var trunkCarMenu: TruncCarMenu
    var activate44_on: Bool = false {
        didSet {
            print("activate44 \(activate44_on)")
        }
    }
    
    override init(mark: String, year: Int, space: Int) {
        self.trunkCarMenu = .new
        super.init(mark: mark, year: year, space: space)
    }
    
    func useTrunkCarMenu(carFunc: TruncCarMenu) {
        switch carFunc  {
        case .activate44: activate44_on.toggle()
        default: break
        }
    }
    
}


let extCond: ExternalConditions = ExternalConditions(engineTemperature: 91, externalTemperature: -30)

let spc:SportCar = SportCar(mark: "aa",year: 111,space: 10)
spc.useSportCarMenu(carFunc: .nitro)
spc.useSportCarMenu(carFunc: .nitro)
//spc.useMenu(carFunc: .engade)
do {
    try spc.useMenu(carFunc: .engade, extC: extCond)
} catch CarError.engineBroken {
    print("двигатель вышел из строя")
} catch CarError.windowBroken {
    print("слишком холодно, не открыть не закрыть")
}

if let pressCode = try? spc.useCode(3) {
    print("код принят")
} else
{
    print("код не принят")
}


let trc:TrunkCar = TrunkCar(mark: "bb", year: 222, space: 20)
trc.useTrunkCarMenu(carFunc: .activate44)
//trc.useMenu(carFunc: .windowOpen)
do{
try trc.useMenu(carFunc: .windowOpen, extC: extCond)
} catch CarError.engineBroken {
    print("двигатель вышел из строя")
} catch CarError.windowBroken {
    print("слишком холодно, не открыть не закрыть")
}
