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
    
    func useMenu(carFunc: CarMenu) {
        switch carFunc  {
        case .engade:
            self.engaged = !self.engaged
            self.engaged ? print("двигатель запущен") : print("двигатель остановлен")
        case .windowOpen:
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

let spc:SportCar = SportCar(mark: "aa",year: 111,space: 10)
spc.useSportCarMenu(carFunc: .nitro)
spc.useSportCarMenu(carFunc: .nitro)
spc.useMenu(carFunc: .engade)

let trc:TrunkCar = TrunkCar(mark: "bb", year: 222, space: 20)
trc.useTrunkCarMenu(carFunc: .activate44)
trc.useMenu(carFunc: .windowOpen)


