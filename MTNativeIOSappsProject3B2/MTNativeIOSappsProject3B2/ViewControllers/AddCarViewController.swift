//
//  AddCarViewController.swift
//  MTNativeIOSappsProject3B2
//
//  Created by Matthias Tison on 31/12/2017.
//  Copyright © 2017 Matthias Tison. All rights reserved.
//

import UIKit

class AddCarViewController: UITableViewController {
    @IBOutlet weak var brandPicker: UIPickerView!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var experienceText: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var car: Car?
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        // looking if we have to edit an existing car
        if let car = car {
            // take index place of brand in all values
            let brandPickerIndex = Car.Brand.values.index(of: car.brand)!
            
            title = "Edit \(car.brand.rawValue)"
            brandPicker.selectRow(brandPickerIndex, inComponent: 0, animated: true)
            typeText.text = car.type
            experienceText.text = car.experience
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddCarViewController.hideKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func saveButtonPushed(_ sender: Any) {
        if(car != nil) {
            performSegue(withIdentifier: "editedCar", sender: self)
        } else {
            performSegue(withIdentifier: "addedCar", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addedCar"?:
            // get the user that is currently logged in -> using his id to link it with the newly created car
            let decoded = userDefaults.object(forKey:"loggedUser") as! Data
            let loggedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! User
            // make a new car with the values in the view, when saving
            let brand = Car.Brand.values[brandPicker.selectedRow(inComponent: 0)]
            car = Car(type: typeText.text!, brand: brand, experience: experienceText.text,userId: loggedUser._id)
        case "editedCar"?:
            car!.type = typeText.text!
            car!.experience = experienceText.text // why no unwrapping needed?
            
            let brand = Car.Brand.values[brandPicker.selectedRow(inComponent: 0)]
            car!.brand = brand
            
            KituraCarService.http.update(withId: car!.carId, to: car!)
        default:
            fatalError("unknown segue")
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

// beforehand link the textfields, that are concerned, with the delegate on the TableviewController "New car", on the main StoryBoard
extension AddCarViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let oldText = text as NSString
            let newText = oldText.replacingCharacters(in: range, with: string)
            saveButton.isEnabled = newText.count > 0
        } else {
            saveButton.isEnabled = string.count > 0
        }
        return true
    }
}

// beforehand link the pickerView with the datasource and delegate on the TableviewController "New car", on the main StoryBoard
extension AddCarViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Car.Brand.values.count
    }
}

extension AddCarViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Car.Brand.values[row].rawValue
    }
}
