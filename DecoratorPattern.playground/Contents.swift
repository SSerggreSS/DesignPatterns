import UIKit

class Beverage {
    
    enum Size {
        case small, medium, large
    }
    
    var size = Size.small
    var description = "Unknown beverage"
    
    func getDescription() -> String {
        description
    }
    
    func setSize(_ size: Size) {
        self.size = size
    }
    
    func getSize() -> Size {
        size
    }
    /// Стоимость напитка
    func cost() -> Float {
        0
    }
}

// MARK: - Implement decorator pattern

class CondimentDecorator: Beverage {
    
    let beverage: Beverage
    
    init(beverage: Beverage) {
        self.beverage = beverage
    }
}

// Еспрессо
class DEspresso: Beverage {
    
    override init() {
        super.init()
        description = "Espresso"
    }
    
    override func cost() -> Float {
        var cost: Float
        switch size {
        case .small:
            cost = 1.99
        case .medium:
            cost = 2.10
        case .large:
            cost = 3.0
        }
        return cost
    }
}

// Домашний кофе
class DHouseBlend: Beverage {
    
    override init() {
        super.init()
        description = "House Blend Coffee"
    }
    
    override func cost() -> Float {
        0.89
    }
}

class DDarkRoast: Beverage {
    
    override init() {
        super.init()
        description = "Dark Roast"
    }
    
    override func cost() -> Float {
        0.99
    }
}

class DDecaf: Beverage {
    
    override init() {
        super.init()
        description = "Decaf"
    }
    
    override func cost() -> Float {
        1.05
    }
}

class Mocha: CondimentDecorator {
    
    override func getDescription() -> String {
        beverage.getDescription() + ", Mocha"
    }
    
    override func cost() -> Float {
        beverage.cost() + 0.20
    }
}

class Soy: CondimentDecorator {
    
    override func getDescription() -> String {
        beverage.getDescription() + ", Soy"
    }
    
    override func cost() -> Float {
        beverage.cost() + calculateCost
    }
    
    private var calculateCost: Float {
        var cost: Float
        switch size {
        case .small:
            cost = 0.10
        case .medium:
            cost = 0.20
        case .large:
            cost = 0.30
        }
        return cost
    }
}

class Whip: CondimentDecorator {
    
    override func getDescription() -> String {
        beverage.getDescription() + ", Whip"
    }
    
    override func cost() -> Float {
        beverage.cost() + 0.10
    }
}

// Cinnamon
class Cinnamon: CondimentDecorator {
    
    override func getDescription() -> String {
        beverage.getDescription() + ", Cinnamon"
    }
    
    override func cost() -> Float {
        beverage.cost() + 1.1
    }
}

final class StarbuzzCoffee {
    func start() {
        // Espresso
        let beverage: Beverage = DEspresso()
        beverage.setSize(.medium)
        print(beverage.getDescription() + " $" + String(beverage.cost()))
        
        // Dark Coffee
        var beverage2: Beverage = DDarkRoast()
        beverage2 = Mocha(beverage: beverage2)
        beverage2 = Mocha(beverage: beverage2)
        beverage2 = Whip(beverage: beverage2)
        print(beverage2.getDescription() + " $" + String(beverage2.cost()))
        
        // Houser Blend
        var beverage3: Beverage = DHouseBlend()
        beverage3.setSize(.medium)
        beverage3 = Soy(beverage: beverage3)
        beverage3.setSize(.small)
        beverage3 = Mocha(beverage: beverage3)
        beverage3 = Whip(beverage: beverage3)
        beverage3 = Cinnamon(beverage: beverage3)
        print(beverage3.getDescription() + " $" + String(beverage3.cost()))
    }
}

let starbuzzCoffee = StarbuzzCoffee()
starbuzzCoffee.start()


// Декорируем Автомобиль

protocol ICar {
    func cost() -> Float
    func description() -> String
}

class CarDecorator: ICar {
    
    let car: ICar
    
    required init(car: ICar) {
        self.car = car
    }
    
    func cost() -> Float {
        car.cost()
    }
    
    func description() -> String {
        car.description()
    }
}

final class MercedesGL: ICar {
    func cost() -> Float {
        30_000.0
    }
    
    func description() -> String {
        "MercedesGL"
    }
}

final class AMG: CarDecorator {
    
    override func cost() -> Float {
        car.cost() + 20_000.0
    }
    
    override func description() -> String {
        car.description() + ", AMG 🅰️"
    }
}

final class Brabus: CarDecorator {
    override func cost() -> Float {
        car.cost() + 100_000.0
    }
    
    override func description() -> String {
        car.description() + ", Brabus 🅱️"
    }
}

final class ShopCars {
    func start() {
        var mercedes: ICar = MercedesGL()
        mercedes = AMG(car: mercedes)
        mercedes = Brabus(car: mercedes)
        print(mercedes.description() + ". Cost:"  + String(mercedes.cost()) + " 💵")
    }
}

let shopCars = ShopCars()
shopCars.start()
