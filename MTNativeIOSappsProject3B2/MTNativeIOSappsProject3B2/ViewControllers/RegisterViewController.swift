//
//  RegisterViewController.swift
//  MTNativeIOSappsProject3B2
//
//  Created by Matthias Tison on 19/12/2017.
//  Copyright © 2017 Matthias Tison. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var adressingNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var repeatPasswordText: UITextField!
    
    
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.hideKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        let adressingName = adressingNameText.text!
        let email = emailText.text!
        let password = passwordText.text!
        let repeatPassword = repeatPasswordText.text!
        
        //Check if every field is filled in
        if(adressingName.isEmpty || email.isEmpty ||
            password.isEmpty || repeatPassword.isEmpty) {
            // Show alert message if one is empty
            displayAlert(message: "Please fill in all the fields",type: "error")
            
            if(adressingName.isEmpty) {
                displayErrorField(field: adressingNameText)
            } else {
                displayErrorField(field: adressingNameText,type: "default")
            }
            
            if(email.isEmpty) {
                displayErrorField(field: emailText)
            } else {
                displayErrorField(field: emailText,type: "default")
            }
            
            if(password.isEmpty) {
                displayErrorField(field: passwordText)
            } else {
                displayErrorField(field: passwordText,type: "default")
            }
            
            if(repeatPassword.isEmpty) {
                displayErrorField(field: repeatPasswordText)
            } else {
                displayErrorField(field: repeatPasswordText,type: "default")
            }
            
            return; // stop user from continuing
        }
        
        if(adressingName.count < 4 || adressingName.count > 15) {
            displayAlert(message: "Your adressing name must be "+(adressingName.count < 4 ? "at least 4":"less than 16")+" characters", type: "error")
            displayErrorField(field: adressingNameText)
            return;
        } else {
            displayErrorField(field: adressingNameText,type: "default")
        }
        
        // Check if the passwords are matching
        if(password != repeatPassword) {
            // Show alert message
            displayAlert(message: "The passwords don't match", type: "error")
            displayErrorField(field: passwordText)
            displayErrorField(field: repeatPasswordText)
            return;
        } else {
            displayErrorField(field: passwordText,type: "default")
            displayErrorField(field: repeatPasswordText,type: "default")
        }
        
        //making an id for the user -> very unsafe code, but just for swift coding
        var madeId = ""
        let baseIntA = Int(arc4random_uniform(10000)) // 3 lines -> SOURCE: StackOverflow: making a random hexadecimal number
        let baseIntB = Int(arc4random_uniform(10000))
        let hexNumber = String(format: "%06X%06X", baseIntA, baseIntB)
        
        for char in adressingName.reversed() {
            madeId += String(char)
        }
        madeId += hexNumber
        print(madeId)
        
        // KituraService.http.create(user)
        
        // Make new user and store the data
        let user = User(adressingName: adressingName, email: email, password: password,id: madeId)
        // unwrap the object or set a default value with '??'
        var users  = userDefaults.object(forKey:"registeredUsers") as? [String:Data] ?? [String:Data]()
        // add new registered user to the dictionary, with that archiving the user object
        users[email] = NSKeyedArchiver.archivedData(withRootObject: user)
       
        userDefaults.set(users, forKey:"registeredUsers")
        
        // Go back to login screen
        displayAlert(message: "You are registered with email: \(email)", type: "succes")
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func displayAlert(message: String, type: String) {
        switch type.lowercased() {
        case "succes":
            let alert = UIAlertController(title: "Success!", message: message, preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { action in
                self.performSegue(withIdentifier: "unwindToLogin", sender: self)
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
    
    func displayErrorField(field: UITextField, type: String? = "") {
        switch type!.lowercased() {
        case "default":
            //cgColor used so the texfield can interpret them
            field.layer.borderColor = UIColor.lightGray.cgColor
            field.layer.borderWidth = 0.0
        default:
            field.layer.borderColor = UIColor.red.cgColor
            field.layer.borderWidth = 0.75
        }
    }
}
