//
//  User.swift
//  MTNativeIOSappsProject3B2
//
//  Created by Matthias Tison on 19/12/2017.
//  Copyright © 2017 Matthias Tison. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding, Codable {
    var _id: String
    var firstname: String
    var lastname: String
    var email: String
    
    init(firstname: String, lastname: String, email: String, id: String? = "" ) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self._id = id!
    }
    
    required init(coder aDecoder: NSCoder) {
        _id = (aDecoder.decodeObject(forKey: "id") as? String)!
        firstname = aDecoder.decodeObject(forKey: "firstname") as! String
        lastname = aDecoder.decodeObject(forKey: "lastname") as! String
        email = aDecoder.decodeObject(forKey: "email") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_id, forKey: "id")
        aCoder.encode(firstname, forKey: "firstname")
        aCoder.encode(lastname, forKey: "lastname")
        aCoder.encode(email, forKey: "email")
    }
}
