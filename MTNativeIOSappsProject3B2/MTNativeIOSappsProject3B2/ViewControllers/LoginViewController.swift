//
//  LoginViewController.swift
//  MTNativeIOSappsProject3B2
//
//  Created by Matthias Tison on 19/12/2017.
//  Copyright © 2017 Matthias Tison. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var notificationLabelText: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        cleanView()
    }
    
    @IBAction func loginButtonPushed(_ sender: Any) {
        // Hide the keyboard when pushing the login button
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
        
        let email = emailText.text!
        let password = passwordText.text!
        
        var registeredUsers = userDefaults.object(forKey: "registeredUsers") as? [String:Data] ?? [String:Data]()
        
        loginButton.isEnabled = false
        registerButton.isEnabled = false
        loginButton.setTitle("Loading..", for: .normal)
        loading.isHidden = false
        
        if(email.isEmpty || password.isEmpty){
            self.notifyUser(message: "All fields should be filled", type: "error")
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { // 1 line -> SOURCE: StackOverflow: making a timeout in swift
                if(registeredUsers[email] != nil) {
                    // Unarchiving the user object so we can read from it, unarchive it to a user object
                    let user = NSKeyedUnarchiver.unarchiveObject(with: registeredUsers[email]!) as! User
                    if(user.password == password) {
                        self.notifyUser(message: "Successful!", type: "success")
                        
                        // Encoding the user trough the keyedArchiver and setting it in the userDefaults local storage
                        let encodedUser = NSKeyedArchiver.archivedData(withRootObject: user)
                        self.userDefaults.set(encodedUser, forKey: "loggedUser")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                            self.performSegue(withIdentifier: "goToWelcome", sender: self)
                            self.cleanView()
                        }
                    } else {
                        self.notifyUser(message: "The password doesn't match the given email", type: "error")
                    }
                } else {
                    self.notifyUser(message: "The given email does not match", type: "error")
                }
            }
        }
    }
    
    func notifyUser(message: String, type: String) {
        switch type.lowercased() {
        case "success":
            notificationLabelText.text = message
            notificationLabelText.textColor = UIColor(red: 0, green: 0.8588, blue: 0.2118, alpha: 1.0) // a darker green color
            notificationLabelText.isHidden = false
        case "error":
            notificationLabelText.text = message
            notificationLabelText.textColor = UIColor.red
            notificationLabelText.isHidden = false
            
            loading.isHidden = true
            
            loginButton.setTitle("Login", for: .normal)
            loginButton.isEnabled = true
            registerButton.isEnabled = true
        default:
            notificationLabelText.text = "Error happend"
            notificationLabelText.textColor = UIColor.red
            notificationLabelText.isHidden = false
            
            loading.isHidden = true
            
            loginButton.setTitle("Login", for: .normal)
            loginButton.isEnabled = true
            registerButton.isEnabled = true
        }
    }
    
    func cleanView() {
        notificationLabelText.isHidden = true
        loading.isHidden = true
        loginButton.setTitle("Login", for: .normal)
        loginButton.isEnabled = true
        registerButton.isEnabled = true
        
        emailText.text = ""
        passwordText.text = ""
    }
}
