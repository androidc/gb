import UIKit

enum CarMenu {
    case engade
    case windowOpen
    case move(movingSpace:Int)
    case new
}

struct SportCar {
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
    
    mutating func useMenu(carFunc: CarMenu) {
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

var SpCar = SportCar(mark: "toyota", year: 2000, space: 100)

SpCar.useMenu(carFunc: .windowOpen)
SpCar.useMenu(carFunc: .windowOpen)
SpCar.useMenu(carFunc: .engade)
SpCar.useMenu(carFunc: .engade)
SpCar.useMenu(carFunc: .move(movingSpace: -10))
SpCar.useMenu(carFunc: .move(movingSpace: 20))
SpCar.useMenu(carFunc: .move(movingSpace: 90))

struct TrunkCar {
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
    
    mutating func useMenu(carFunc: CarMenu) {
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


var TrCar = TrunkCar(mark: "volvo", year: 2010, space: 1000)

TrCar.useMenu(carFunc: .windowOpen)
TrCar.useMenu(carFunc: .windowOpen)
TrCar.useMenu(carFunc: .engade)
TrCar.useMenu(carFunc: .engade)
TrCar.useMenu(carFunc: .move(movingSpace: -10))
TrCar.useMenu(carFunc: .move(movingSpace: 20))
TrCar.useMenu(carFunc: .move(movingSpace: 90))


