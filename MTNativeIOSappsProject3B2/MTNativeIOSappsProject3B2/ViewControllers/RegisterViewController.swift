//
//  RegisterViewController.swift
//  MTNativeIOSappsProject3B2
//
//  Created by Matthias Tison on 19/12/2017.
//  Copyright © 2017 Matthias Tison. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var repeatPasswordText: UITextField!
    
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func alreadyAccountButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        let email = emailText.text!
        let password = passwordText.text!
        let repeatPassword = repeatPasswordText.text!
        
        //Check if every field is filled in
        if(email.isEmpty || password.isEmpty || repeatPassword.isEmpty) {
            // Show alert message
            displayAlert(message: "Please fill in all the fields",type: "error")
            return; // stop user from continuing
        }
        
        // Check if the passwords are matching
        if(password != repeatPassword) {
            // Show alert message
            displayAlert(message: "The passwords don't match", type: "error")
            return;
        }
        
        // Make new user and store the data
        let user = User(firstname: "defaultfirstname", lastname: "defaultlastname", email: email)
        // Encoding the user trough the keyedArchiver and setting it in the userDefaults local storage
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: user)
        userDefaults.set(encodedData, forKey:"loggedUser")
        
        let decoded  = userDefaults.object(forKey:"loggedUser") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! User
        print(decodedUser.email)
        
        // KituraService.http.create(user)
        
        
        // Go back to login screen
        displayAlert(message: "You are registered with email: \(email)", type: "succes")
    }
    
    func displayAlert(message: String, type: String) {
        switch type.lowercased() {
        case "succes":
            let alert = UIAlertController(title: "Success!", message: message, preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { action in
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        case "error":
            let alert = UIAlertController(title: "Oeps!", message: message, preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        default:
            let alert = UIAlertController(title: "Error", message: "Error happend", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
