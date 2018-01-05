//
//  CarsViewController.swift
//  MTNativeIOSappsProject3B2
//
//  Created by Matthias Tison on 31/12/2017.
//  Copyright © 2017 Matthias Tison. All rights reserved.
//

import UIKit

class CarsViewController: UIViewController {
    @IBOutlet weak var carTableView: UITableView!
    
    
    var userDefaults = UserDefaults.standard
    var cars: [Car] = []
    
    // the index in the tabel of the car that is going to be edited
    var indexCarToEdit: IndexPath!
    
    override func viewDidLoad() {
        KituraCarService.http.getCars {
            if let cars = $0 {
                self.cars = cars
                // reload the table's data so changes can be seen
                self.carTableView.reloadData()
            }
        }
        
        // LongPressGestureRecognizer to listen to long press on screen, when long press occures, then do action accordingly
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(CarsViewController.longPress))
        longPressRecognizer.minimumPressDuration = 1 // #seconds the user has to press before action is taken
        carTableView.addGestureRecognizer(longPressRecognizer)
    }
    
    @IBAction func logoutButtonPushed(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "Do you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction1 = UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil)
        let alertAction2 = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { action in
            // having to use 'self.' because in another closure, to make explicit
            self.performSegue(withIdentifier: "unwindToLoginAsLogout", sender: self)
            self.userDefaults.removeObject(forKey: "loggedUser")
        }
        
        alert.addAction(alertAction1)
        alert.addAction(alertAction2)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addCar"?:
            // no preperation, there is going to be a new car made
            break
        case "unwindToLoginAsLogout"?:
            // no preperation needed
            break
        case "editCar"?:
            // add the car that is selected for editing to the AddCarViewController, so it can be edited
            let addCarController = segue.destination as! AddCarViewController
            addCarController.car = cars[indexCarToEdit.row]
        default:
            fatalError("unknown segue")
        }
    }
    
    @IBAction func unwindFromAddCar(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "addedCar"?:
            // append the newly made car, from the AddCarViewController, to the cars in the CarsViewController
            let addCarController = segue.source as! AddCarViewController
            cars.append(addCarController.car!)
            // add new row to the tableview so the added car is seen, with according animation
            carTableView.insertRows(at: [IndexPath(row: cars.count - 1, section: 0)], with: .fade)
            KituraCarService.http.create(cars.last!)
        case "editedCar"?:
            carTableView.reloadRows(at: [indexCarToEdit], with: .automatic)
            carTableView.deselectRow(at: indexCarToEdit, animated: true)
        default:
            fatalError("unkown segue")
        }
    }
    
    // we have to add "@obj" in swift4, before it was implicit
    @objc /* -> SOURCE: StackOverflow: '#selector' refers to a method that is not exposed to Objective-C*/
        func longPress(_ press:UILongPressGestureRecognizer) {
            if press.state == .began {
                let touchPoint = press.location(in: carTableView)
                self.indexCarToEdit = carTableView.indexPathForRow(at: touchPoint)
                self.performSegue(withIdentifier: "editCar", sender: self)
            }
    }
}

// extension to manage the data in the tableview
extension CarsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! CarCellView
        cell.car = cars[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
}

// extension to manage actions done in the carTableView
extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
                let car = self.cars.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                KituraCarService.http.delete(withType: car.type)
                completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
