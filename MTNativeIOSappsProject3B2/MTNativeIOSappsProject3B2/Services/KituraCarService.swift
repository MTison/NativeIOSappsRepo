//
//  KituraCarService.swift
//  MTNativeIOSappsProject3B2
//
//  Created by Matthias Tison on 04/01/2018.
//  Copyright © 2018 Matthias Tison. All rights reserved.
//

import KituraKit

class KituraCarService {
    
    private init() {}
    static let http = KituraCarService()
    
    private let db = KituraKit(baseURL: "http://localhost:8080")!
    
    func getCars(completion: @escaping ([Car]?) -> Void) {
        db.get("/cars") {
            (cars: [Car]?, error: RequestError?) in
            if let error = error {
                print("Error while loading cars: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion(cars)
            }
        }
    }
    
    func create(_ car: Car) {
        db.post("/cars", data: car) {
            (result: Car?, error: RequestError?) in
            if let error = error {
                print("Error while creating the car \(car.brand.rawValue) - \(car.type): \(error.localizedDescription)")
            } else {
                print("succes")
            }
        }
    }
    
    func update(withType type: String,to car: Car) {
        db.put("/cars", identifier: type, data: car) {
            (result: Car?, error: RequestError?) in
            if let error = error {
                print("Error while updating the car \(car.brand.rawValue) - \(car.type): \(error.localizedDescription)")
            }
        }
    }
    
    func delete(withType type: String) {
        db.delete("/cars", identifier: type) {
            (error: RequestError?) in
            if let error = error {
                print("Error while deleting the car with type \(type): \(error.localizedDescription)")
            }
        }
    }
}

