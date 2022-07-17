import UIKit
import Foundation

// MARK: - Protocols

protocol Subject {
    func registerObserver(o: Observer)
    func removeObserver(o: Observer)
    func notifyObservers()
}

//extension Subject: Equatable { }

protocol Observer: AnyObject {
//    func update(temp: Float, humidity: Float, pressure: Float)
    func update()
}

protocol DisplayElement {
    func display()
}

final class WeatherData {
    
    private var observers: [Observer]
    private var temperature: Float?
    private var humidity: Float?
    private var pressure: Float?
    
    init() {
        observers = [Observer]()
    }
    
    public func getTemperature() -> Float {
        Float.random(in: -30...30)
    }
    
    public func getHumidity() -> Float {
        Float.random(in: 0...100)
    }
    
    func getPressure() -> Float {
        Float.random(in: 0...200)
    }
    
}

// MARK: Subject

extension WeatherData: Subject {
    
    /// Регистрирует обозревателя
    func registerObserver(o: Observer) {
        observers.append(o)
    }
    
    /// Удаляет обозревателя из списка
    func removeObserver(o: Observer) {
        observers = observers.filter { $0 !== o }
    }
    
    /// Оповещает обозревателей об измененях
    func notifyObservers() {
        observers.forEach { $0.update() }
    }
    
    /// Показатели изменились
    func measurementsChanged() {
        notifyObservers()
    }
    
    public func setMeasurements(
        temperature: Float,
        humidity: Float,
        pressure: Float
    ) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        measurementsChanged()
    }
    
    // Another methods WeatherData
}

/// MARK: - Displays

final class CurrentConditionsDisplay: Observer, DisplayElement {
  
    private var temperature: Float?
    private var humidity: Float?
    private var weatherData: WeatherData?
    
    init(weatherData: WeatherData) {
        self.weatherData = weatherData
        self.weatherData?.registerObserver(o: self)
    }
    
    func update() {
        temperature = weatherData?.getTemperature() ?? 0
        humidity = weatherData?.getHumidity() ?? 0
        display()
    }
    
    func display() {
        print("Current conditions: \(temperature ?? 0) F degrees and \(humidity ?? 0)")
    }
}

final class StatisticsDisplay: Observer, DisplayElement {
    
    private var weatherData: WeatherData
    private var temp: Float?
    private var humidity: Float?
    private var pressure: Float?
    
    init(weatherData: WeatherData) {
        self.weatherData = weatherData
        self.weatherData.registerObserver(o: self)
    }
    
    // MARK: - Observer
    func update() {
        self.temp = weatherData.getTemperature()
        self.humidity = weatherData.getHumidity()
        self.pressure = weatherData.getPressure()
        display()
    }
    
    // MARK: - DisplayElement
    func display() {
        print("StatisticsDisplay: temp \(temp ?? 0) humidity \(humidity ?? 0) pressure \(pressure ?? 0)")
    }
}

final class ForecastDisplay: Observer, DisplayElement {
    
    private var weatherData: WeatherData
    private var temp: Float?
    private var humidity: Float?
    private var pressure: Float?
    
    init(weatherData: WeatherData) {
        self.weatherData = weatherData
        weatherData.registerObserver(o: self)
    }
    
    // MARK: - Observer
    func update() {
        self.temp = weatherData.getTemperature()
        self.humidity = weatherData.getHumidity()
        self.pressure = weatherData.getPressure()
        display()
    }
    
    // MARK: - DisplayElement
    func display() {
        print("ForecastDisplay:  temp \(temp ?? 0) humidity \(humidity ?? 0) pressure \(pressure ?? 0)")
    }
    
}

// создание субъекта
let weatherData = WeatherData()

// создание обозревателя CurrentConditionsDisplay
let currentDispey = CurrentConditionsDisplay(weatherData: weatherData)

// создание обозревателя StatisticsDisplay
let statisticDisplay = StatisticsDisplay(weatherData: weatherData)

// создание ForecastDisplay
let forecastDisplay = ForecastDisplay(weatherData: weatherData)

// распостраненние изменений
weatherData.setMeasurements(temperature: 30, humidity: 30, pressure: 30)
weatherData.setMeasurements(temperature: 50, humidity: 50, pressure: 50)
weatherData.setMeasurements(temperature: 70, humidity: 70, pressure: 70)

weatherData.removeObserver(o: currentDispey)
print("\nОтписались от обозревания для объекта currentDispey")
weatherData.setMeasurements(temperature: 90, humidity: 90, pressure: 90)

//1 есть магазин Кроха
//2 при изменении цен на товары магазин делает рассылку с наименованием товара и цены

//реализовать с помощью паттерна Observer

protocol IObserver: AnyObject {
    func getPriceGoods(price: [String: Float])
}

protocol ISubject: AnyObject {
    init(observers: [IObserver])
    func register(observer: IObserver)
    func remove(observer: IObserver)
    func notifyObservers()
}

final class ShopCrumbs: ISubject {
    
    private var price = [String: Float]()
    private var observers: [IObserver]
    
    init(observers: [IObserver]) {
        self.observers = observers
    }
    
    func getPriceGoods(price: [String : Float]) {
        self.price = price
        notifyObservers()
    }
    
    func register(observer: IObserver) {
        observers.append(observer)
    }
    
    func remove(observer: IObserver) {
        observers.filter { $0 !== observer }
    }
    
    func notifyObservers() {
        observers.forEach { $0.getPriceGoods(price: price) }
    }
}

final class ClientShopCrumbs: IObserver {
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPriceGoods(price: [String : Float]) {
        price.forEach { print("Name client: \(name)\nName good: \($0.key), price: \($0.value)") }
    }
}

// Observers
let clients = [
    ClientShopCrumbs(name: "Maria"),
    ClientShopCrumbs(name: "Boris"),
    ClientShopCrumbs(name: "Serg")
]

// Инициализация субъекта
let shopCrumbs = ShopCrumbs(observers: clients)

// Получение прайса цен
shopCrumbs.getPriceGoods(price: [
    "Diapers" : 2_500.0,
    "Pram": 90_000.0,
    "Cot": 70_000.0
])

shopCrumbs.getPriceGoods(price: ["Feeding Chair": 10_000.0])
