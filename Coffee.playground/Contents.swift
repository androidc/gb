import UIKit



//Еще один классический пример: создание различных вариаций кофе (простой, с молоком, с сахаром, с молоком и сахаром, со сливками, с молоком, сахаром и сливками и т. д.) с помощью декорирования — вместо создания большого количества сабклассов кофе.
//Создайте протокол Coffee и класс SimpleCoffee, реализующий протокол Coffee. Создайте протокол CoffeeDecorator, который «наследуется» от протокола Coffee. Далее создайте реализации декоратора — Milk, Whip, Sugar и другие, которые будут ингредиентами, которые добавляют в кофе. В протоколе Coffee объявите переменную cost: Int — это цена кофе. Каждый ингредиент должен увеличивать цену кофе на свою стоимость. Реализуйте описанную систему объектов с помощью паттерна Decorator аналогично тому, как это было сделано на уроке.

protocol Coffee {
    var cost: Int {get}
}

class SimpleCoffee : Coffee {
    var cost: Int {
        return 100
    }
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee {get}
    
    init(_ base:Coffee)
}

class Milk: CoffeeDecorator {
    let base: Coffee
    
    var cost: Int {
        return base.cost + 100
    }
    
    required init(_ base: Coffee) {
        self.base = base
    }
}

class Sugar: CoffeeDecorator {
    let base: Coffee
    
    var cost: Int {
        return base.cost + 50
    }
    
    required init(_ base: Coffee) {
        self.base = base
    }
}

class Whip: CoffeeDecorator {
    let base: Coffee
    
    var cost: Int {
        return base.cost + 150
    }
    
    required init(_ base: Coffee) {
        self.base = base
    }
}

let simple = SimpleCoffee()
let milk = Milk(simple)
let sugar = Sugar(simple)
let sugarMilk = Milk(Sugar(simple))
let sugarMilkWhip = Milk(Sugar(Whip(simple)))

print(simple.cost)
print(milk.cost)
print(sugar.cost)
print(sugarMilk.cost)
print(sugarMilkWhip.cost)






