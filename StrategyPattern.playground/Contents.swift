
// MARK: protocols
protocol FlyingBehaviorInterface: AnyObject {
    func fly()
}

protocol SwimmingPool {
    func swimming()
}

protocol QuackBehaviorInterface: AnyObject {
    func quack()
}

class Duck {

    var quackBehavior: QuackBehaviorInterface?
    var flyBehavior: FlyingBehaviorInterface?

    func performQuack() {
        quackBehavior?.quack()
    }

    func performFly() {
        flyBehavior?.fly()
    }

    func setFlyBehavior(fb: FlyingBehaviorInterface) {
        flyBehavior = fb
    }

    func setQuackBehavior(qb: QuackBehaviorInterface) {
        quackBehavior = qb
    }

    func toStand() {
        print("\(String(describing: Self.self)) to stand!")
    }
}

class MallardDuck: Duck {

    override init() {
        super.init()
        let qb = QuackBehaviorObject()
        quackBehavior = qb
        let fb = FlyingBehaviorObject()
        flyBehavior = fb
    }
}

// MARK: - Delegate QuackBehaviorInterface

final class QuackBehaviorObject: QuackBehaviorInterface {
    func quack() {
        print("\(String(describing: Self.self)) to quack 🦆!")
    }
}

// MARK: - Delegate FlyingBehaviorInterface

final class FlyingBehaviorObject: FlyingBehaviorInterface {
    func fly() {
        print("\(String(describing: Self.self)) to fly 🛫!")
    }
}

class FlyRocketPowered: FlyingBehaviorInterface {
    func fly() {
        print("\(String(describing: Self.self)) to fly 🛫!")
    }
}

let mallarDuck = MallardDuck()
mallarDuck.performQuack()
mallarDuck.performFly()
mallarDuck.setFlyBehavior(fb: FlyRocketPowered())
mallarDuck.performFly()


/* another example */

// Strategy

protocol Strategy {
    func doAction(a: Double, b: Double) -> Double
}

final class Multy: Strategy {
    func doAction(a: Double, b: Double) -> Double {
        a * b
    }
}

final class Sum: Strategy {
    func doAction(a: Double, b: Double) -> Double {
        a + b
    }
}

final class Div: Strategy {
    func doAction(a: Double, b: Double) -> Double {
        a / b
    }
}

final class Math {

    private var instance: Strategy

    init(strategy: Strategy) {
        instance = strategy
    }

    func setStrategy(strategy: Strategy) {
        instance = strategy
    }

    func doAction(a: Double, b: Double) -> Double {
        instance.doAction(a: a, b: b)
    }
}

var m = Math(strategy: Sum())
m.doAction(a: 11, b: 11)
m.setStrategy(strategy: Div())
m.doAction(a: 200, b: 2)
m.setStrategy(strategy: Multy())
m.doAction(a: 3, b: 3)

/* вывод: стратегия позволяет динамически менять повидение*/

protocol CurrenciesStrategy {
    func getCourses()
}

final class GetFromCB: CurrenciesStrategy {
    func getCourses() {
        print("Получаем из ЦБ")
    }
}

final class GetFromYahoo: CurrenciesStrategy {
    func getCourses() {
        print("Получаем из яхо")
    }
}

final class Converter {

    private var instance: CurrenciesStrategy

    init(strategy: CurrenciesStrategy) {
        instance = strategy
    }

    // Динамическая смена повидения
    func set(strategy: CurrenciesStrategy) {
        instance = strategy
    }

    func getCourses() {
        instance.getCourses()
    }
}

// MARK: - Strategy Mortal Combat

// MARK: Interfaces

protocol FatalityBehavior {
    func makingFatalities()
}

final class ScorpioFatality: FatalityBehavior {
    func makingFatalities() {
        print("\(String(describing: Self.self)) making fatality 🦂")
    }
}

final class SabziroFatality: FatalityBehavior {
    func makingFatalities() {
        print("\(String(describing: Self.self)) making fatality 🥶")
    }
}

final class ShangZongFatalaty: FatalityBehavior {
    func makingFatalities() {
        print("\(String(describing: Self.self)) making fatality 🐉")
    }
}

// MARK: - Base Character class

class Character {

    private var health = 100

    private var fatalityMaker: FatalityBehavior?

    init(fatalityMaker: FatalityBehavior? = nil) {
        self.fatalityMaker = fatalityMaker
    }

    func prepareFatality() {
        fatalityMaker?.makingFatalities()
    }

    func setFatalityMaker(fm: FatalityBehavior) {
        fatalityMaker = fm
    }

    func reduceHealth(value: Int) {
        health -= value
    }

    func displayed() {
        // override method
    }
}

// MARK: - Characters Mortal Combat

final class Scorpio: Character {
    override func displayed() {
        super.displayed()
        print("Displayed \(String(describing: Self.self)) 🦂")
    }
}

final class Sabziro: Character {
    override func displayed() {
        super.displayed()
        print("Displayed \(String(describing: Self.self)) 🥶")
    }
}

final class ShangZong: Character {
    override func displayed() {
        super.displayed()
        print("Displayed \(String(describing: Self.self)) 🐉")
    }
}

let scorpio = Scorpio(fatalityMaker: ScorpioFatality())
scorpio.displayed()
scorpio.prepareFatality()

let sabziro = Sabziro()
sabziro.displayed()
sabziro.setFatalityMaker(fm: SabziroFatality())
sabziro.prepareFatality()

let shangZong = ShangZong(fatalityMaker: ShangZongFatalaty())
shangZong.displayed()
shangZong.prepareFatality()
shangZong.setFatalityMaker(fm: SabziroFatality())
shangZong.prepareFatality()

// MARK: - SortedStrategy

protocol SortedStrategy {
    func doAlgorithm<T: Comparable>(data: [T]) -> [T]
}

final class SortedObject {

    private var strategy: SortedStrategy

    init(strategy: SortedStrategy) {
        self.strategy = strategy
    }

    func doSomeSorted<T: Comparable>(data: [T]) -> [T] {
        strategy.doAlgorithm(data: data)
    }
}

// MARK: - example with Car

protocol IBreakBehavior: AnyObject {
    func doBreak()
}

final class BreakWithABS: IBreakBehavior {
    func doBreak() {
        print("BreakWithABS \(#function)")
    }
}

final class BreakWithoutABS: IBreakBehavior {
    func doBreak() {
        print("BreakWithoutABS \(#function)")
    }
}

final class Car {

    private var breakBehavior: IBreakBehavior

    // Устанавливает объект поддерживающий интерфейс IBreakBehavior
    init(breakBehavior: IBreakBehavior) {
        self.breakBehavior = breakBehavior
    }

    // Динамически меняем стратегию поведения торможения автомобиля
    func setBreakBehavior(bb: IBreakBehavior) {
        breakBehavior = bb
    }

    func prepareBreak() {
        breakBehavior.doBreak()
    }

}

let absBreakBehavior: IBreakBehavior = BreakWithABS()
let car = Car(breakBehavior: absBreakBehavior)
car.prepareBreak()

let breakWithoutABS: IBreakBehavior = BreakWithoutABS()
car.setBreakBehavior(bb: breakWithoutABS)
car.prepareBreak()

/*
 Предусловия: есть транспортоное средство с тремя видами повидения, по суше, по воде, по небу.
 задание: разработать повидение для транспортного средства реализующий паттерн стратегия
 */

protocol IDrivingBehavior {
    func driving()
}

protocol ISwimmingBehavior {
    func swimming()
}

protocol IFlyBehavior {
    func fly()
}

protocol IVehicle {
    func fly()
    func drive()
    func swimming()
    func setFlyBehavior(_ behavior: IFlyBehavior)
    func setDriveBehavior(_ behavior: IDrivingBehavior)
    func setSwimmingBehavior(_ behavior: ISwimmingBehavior)
}

class Vehicle: IVehicle {

    private var flyBehavior: IFlyBehavior?
    private var driveBehavior: IDrivingBehavior?
    private var swimmingBehavior: ISwimmingBehavior?

    init(
        flyBehavior: IFlyBehavior? = nil,
        driveBehavior: IDrivingBehavior? = nil,
        swimmingBehavior: ISwimmingBehavior? = nil
    ) {
        self.flyBehavior = flyBehavior
        self.driveBehavior = driveBehavior
        self.swimmingBehavior = swimmingBehavior
    }

    public func setFlyBehavior(_ behavior: IFlyBehavior) {
        flyBehavior = behavior
    }

    public func setDriveBehavior(_ behavior: IDrivingBehavior) {
        driveBehavior = behavior
    }

    public func setSwimmingBehavior(_ behavior: ISwimmingBehavior) {
        swimmingBehavior = behavior
    }

    public func fly() {
        flyBehavior?.fly()
    }

    public func drive() {
        driveBehavior?.driving()
    }

    public func swimming() {
        swimmingBehavior?.swimming()
    }
}

final class DrivingBehaviorObject: IDrivingBehavior {
    func driving() {
        print("\(String(describing: Self.self)) driving!")
    }
}

final class FlyBehaviorObject: IFlyBehavior {
    func fly() {
        print("\(String(describing: Self.self)) fly!")
    }
}

final class SwimmingBehaviorObject: ISwimmingBehavior {
    func swimming() {
        print("\(String(describing: Self.self)) swimming!")
    }
}

final class ScubaDivingBehaviorObject: ISwimmingBehavior {
    func swimming() {
        print("\(String(describing: Self.self)) Scuba Diving!")
    }
}

final class Mercedes: Vehicle {

}

final class Helicopter: Vehicle {

}

final class Yacht: Vehicle {

}

let mercedesVehicle: IVehicle = Mercedes()
mercedesVehicle.drive()
mercedesVehicle.setDriveBehavior(DrivingBehaviorObject())
mercedesVehicle.drive()

let helicopter: IVehicle = Helicopter()
helicopter.setFlyBehavior(FlyBehaviorObject())
helicopter.fly()

let yacht: IVehicle = Yacht(swimmingBehavior: SwimmingBehaviorObject())
yacht.swimming()
yacht.setSwimmingBehavior(ScubaDivingBehaviorObject())
yacht.swimming()




protocol IStrategyWeather {
    func getWeather() -> String
}

extension IStrategyWeather {
    func getWeather() -> String {
        "No weather"
    }
}

final class WeatherFetcher {
    
    private var weatherFetcher: IStrategyWeather?
    
    init(weatherFetcher: IStrategyWeather? = nil) {
        self.weatherFetcher = weatherFetcher
    }
    
    func set(weatherFetcher: IStrategyWeather) {
        self.weatherFetcher = weatherFetcher
    }
    
    func getWeather() {
        print(weatherFetcher?.getWeather() ?? "")
    }
}

final class MoscowWeatherTower: IStrategyWeather {
    func getWeather() -> String {
        "Moscow very coldly 🥶"
    }
}

final class StavropolWeatherTower: IStrategyWeather {
    func getWeather() -> String {
        "Stavropol is warm ☀️"
    }
}

final class ColoradoWeatherTower: IStrategyWeather {
    func getWeather() -> String {
        "Colorado very hot 🔥"
    }
}

let stavropolTower = StavropolWeatherTower()
let weatherFetcher = WeatherFetcher(weatherFetcher: stavropolTower)
weatherFetcher.getWeather()

let moscowTower = MoscowWeatherTower()
weatherFetcher.set(weatherFetcher: moscowTower)
weatherFetcher.getWeather()

let coloradoTower = ColoradoWeatherTower()
weatherFetcher.set(weatherFetcher: coloradoTower)
weatherFetcher.getWeather()


// MARK: - Printing Strategy

protocol IPrintStrategy {
    func printing(string: String)
}

final class LowerCasePrinter: IPrintStrategy {
    func printing(string: String) {
        print(string.lowercased())
    }
}

final class UpperCasePrinter: IPrintStrategy {
    func printing(string: String) {
        print(string.uppercased())
    }
}

final class CamelCasePrinter: IPrintStrategy {
    func printing(string: String) {
//        var str = string
//        str.lowercased()
//        var character = ""
//        for (i,char) in str.enumerated() where i % 2 == 0 {
//            character = char.uppercased()
//            str.append(character)
//        }
        var resultStr = ""
        string.lowercased().enumerated().forEach { i, s in
            var s = String(s)
            if i % 2 == 0 {
                s = s.uppercased()
            }
            resultStr.append(s)
        }
        print(resultStr)
    }
}

final class Printer {
    
    private var printStrategy: IPrintStrategy
    
    required init(strategy: IPrintStrategy) {
        printStrategy = strategy
    }
    
    public func setStrategy(_ strategy: IPrintStrategy) {
        printStrategy = strategy
    }
    
    public func printing(string: String) {
        printStrategy.printing(string: string)
    }
}

let printString = "Hello World!!!"
let lowwerStrategy = LowerCasePrinter()
let printer = Printer(strategy: lowwerStrategy)
printer.printing(string: printString)

let upperStrategy = UpperCasePrinter()
printer.setStrategy(upperStrategy)
printer.printing(string: printString)

let camelCaseStrategy = CamelCasePrinter()
printer.setStrategy(camelCaseStrategy)
printer.printing(string: printString)
