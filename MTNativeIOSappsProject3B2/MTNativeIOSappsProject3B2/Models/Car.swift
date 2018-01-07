//
//  Car.swift
//  MTNativeIOSappsProject3B2
//
//  Created by Matthias Tison on 02/01/2018.
//  Copyright © 2018 Matthias Tison. All rights reserved.
//

import UIKit

class Car: Codable {
    
    enum Brand: String, Codable {
        case Hyundai = "Hyundai"
        case Mercedes = "Mercedes"
        case Honda = "Honda"
        case Citroën = "Citroën"
        case Renault = "Renault"
        case Toyota = "Toyota"
        case Volkswagen = "Volkswagen"
        case BMW = "BMW"
        case Audi = "Audi"
        case Fiat = "Fiat"
        
        static let values = [Brand.Hyundai, .Mercedes , .Honda, .Citroën, .Renault, .Toyota, .Volkswagen, .BMW, .Audi, .Fiat]
    }
    
    var carId: String
    var type: String
    var brand: Brand
    var experience: String
    var userId: String
    
    init(type: String,brand: Brand,experience: String, userId: String) {
        self.type = type
        self.brand = brand
        self.experience = experience
        self.userId = userId
        
        //making an id for the car -> very unsafe code, but just for swift coding
        var madeId = ""
        let baseIntA = Int(arc4random_uniform(10000))
        let baseIntB = Int(arc4random_uniform(10000))
        let hexNumber = String(format: "%06X%06X", baseIntA, baseIntB)
        
        for char in type.reversed() {
            madeId += String(char)
        }
        self.carId = madeId + hexNumber
    }
}
