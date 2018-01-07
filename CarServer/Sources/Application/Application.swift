import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
    let router = Router()
    
    private var cars: [String: Car] = [:]
    private var users: [String: User] = [:]
    
    let cloudEnv = CloudEnv()

    public init() throws {
    }

    func postInit() throws {
        // Capabilities
        initializeMetrics(app: self)

        // Endpoints
        initializeHealthRoutes(app: self)
        
        router.post("/cars", handler: postCarHandler)
        router.get("/cars", handler: getCarHandler)
        router.get("/cars/", handler: getCarsWithUserIdHandler)
        router.delete("/car/", handler: deleteCarHandler)
        router.patch("/", handler: updateCarHandler)
        
        router.post("/users", handler: postUserHandler)
        router.get("/users", handler: getUserHandler)
    }
    
    // calls for cars
    func postCarHandler(car: Car, completion: (Car?, RequestError?) -> Void ) -> Void {
        cars[car.carId] = car
        completion(cars[car.carId], nil)
    }
    func getCarHandler(completion: ([Car]?, RequestError?) -> Void ) -> Void {
        let cars: [Car] = self.cars.map({ $0.value })
        completion(cars, nil)
    }
    func getCarsWithUserIdHandler(userId: String, completion: ([Car]?, RequestError?) -> Void) -> Void {
        // custom getter -> getting all cars with a specific userId (get cars of person x with given userId)
        let cars: [Car] = self.cars.map({ $0.value }).filter({ $0.userId == userId })
        completion(cars, nil)
    }
    func deleteCarHandler(id: String, completion: (RequestError?) -> Void ) -> Void {
        cars[id] = nil
        completion(nil)
    }
    func updateCarHandler(id: String, new: Car, completion: (Car?,RequestError?) -> Void ) -> Void {
        cars[id] = new
        completion(cars[id], nil)
    }
    
    // calls for users
    func postUserHandler(user: User, completion: (User?, RequestError?) -> Void ) -> Void {
        users[user._id] = user
        completion(users[user._id], nil)
    }
    func getUserHandler(completion: ([User]?, RequestError?) -> Void ) -> Void {
        let users: [User] = self.users.map({ $0.value })
        completion(users, nil)
    }


    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
