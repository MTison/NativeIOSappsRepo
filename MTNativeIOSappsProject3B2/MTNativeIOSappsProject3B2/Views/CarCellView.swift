//
//  CarCellView.swift
//  MTNativeIOSappsProject3B2
//
//  Created by Matthias Tison on 02/01/2018.
//  Copyright © 2018 Matthias Tison. All rights reserved.
//

import UIKit

class CarCellView: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    
    // when a car is set to the cell, it fills up the values of the cell in the view
    var car: Car! {
        didSet {
            self.typeLabel.text = car.type
            self.brandLabel.text = car.brand.rawValue
            self.setBrandImage(brand: car.brand.rawValue)
        }
    }
    
    func setBrandImage(brand: String) {
        switch brand {
        case "Hyundai":
            self.carImageView.image = UIImage(named: "HyundaiLogo")
        case "Mercedes":
            self.carImageView.image = UIImage(named: "mercedesLogo")
        case "Honda":
            self.carImageView.image = UIImage(named: "HondaLogo")
        case "Citroën":
            self.carImageView.image = UIImage(named: "CitroenLogo")
        case "Renault":
            self.carImageView.image = UIImage(named: "RenaultLogo")
        case "Toyota":
            self.carImageView.image = UIImage(named: "ToyotaLogo")
        case "Volkswagen":
            self.carImageView.image = UIImage(named: "VwLogo")
        case "BMW":
            self.carImageView.image = UIImage(named: "BmwLogo")
        case "Audi":
            self.carImageView.image = UIImage(named: "AudiLogo")
        case "Fiat":
            self.carImageView.image = UIImage(named: "FiatLogo")
        default:
            self.carImageView.image = UIImage(named: "CarIcon300x300")
        }
    }
}
