// Gym
protocol IExercise {
    var name: String { get }
    var type: String { get }
    
    func start()
    func stop()
}

extension IExercise {
    func start() {
        print("Начали \(name)")
    }
    
    func stop() {
        print("Закончили \(name)")
    }
}

final class Jumping: IExercise {
    let name = "Прыжки"
    let type = "Упражнение для ног"
}

final class Squat: IExercise {
    let name = "Приседания"
    let type = "Упражнение для ног"
}

final class PushUps: IExercise {
    let name = "Отжимания"
    let type = "Упражнение для рук"
}

enum ExerciseType {
    case jumping, squat, pushUps
}

final class ExerciseFactory {
    func createExercise(by type: ExerciseType) -> IExercise {
        switch type {
        case .jumping: return Jumping()
        case .squat: return Squat()
        case .pushUps: return PushUps()
        }
    }
}

final class Gym {
    
    private var exercises = [IExercise]()
    
    private let exerciseFactory: ExerciseFactory
    
    init(exerciseFactory: ExerciseFactory) {
        self.exerciseFactory = exerciseFactory
    }
    
    func createExerciseBy(type: ExerciseType) {
        let exercise = exerciseFactory.createExercise(by: type)
        exercises.append(exercise)
    }
    
    func startExercises() {
        exercises.forEach { $0.start(); $0.stop() }
    }
}

let exerciseFactory = ExerciseFactory()
let gym = Gym(exerciseFactory: exerciseFactory)
gym.createExerciseBy(type: .jumping)
gym.createExerciseBy(type: .squat)
gym.createExerciseBy(type: .pushUps)
gym.startExercises()



// Transportation

enum VehicleType {
    case ground, air, water
}

protocol IVehicle {
    var name: String { get }
    var type: VehicleType { get }
    
    func deliverCargo()
    func backToBase()
}

extension IVehicle {
    func deliverCargo() {
        print("\(name) доставляет груз")
    }
    
    func backToBase() {
        print("\(name) возвращается на базу")
    }
}

final class Bicycle: IVehicle {
    var name = "Bicycle"
    var type: VehicleType = .ground
}

final class Boat: IVehicle {
    var name = "Boat"
    var type: VehicleType = .water
}

final class Kite: IVehicle {
    var name = "Kite"
    var type: VehicleType = .air
}

final class VehicleFactory {
    func createVehicle(by type: VehicleType) -> IVehicle {
        switch type {
        case .ground: return Bicycle()
        case .water: return Boat()
        case .air: return Kite()
        }
    }
}

final class CargoDelivery {
    
    private var vehicles = [IVehicle]()
    private let vehicleFactory: VehicleFactory
    
    init(vehicleFactory: VehicleFactory) {
        self.vehicleFactory = vehicleFactory
    }
    
    func makeDeliveryTo(vehicleTypes: [VehicleType]) {
        vehicleTypes.forEach { vehicles.append(vehicleFactory.createVehicle(by: $0)) }
    }
    
    func deliverCargo() {
        vehicles.forEach { $0.deliverCargo(); $0.backToBase() }
    }
}
let vehicleFactory = VehicleFactory()
let cargoDelivery = CargoDelivery(vehicleFactory: vehicleFactory)
cargoDelivery.makeDeliveryTo(vehicleTypes: [.ground, .water, .air, .air, .ground])
cargoDelivery.deliverCargo()
