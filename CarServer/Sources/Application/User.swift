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
    var adressingName: String
    var email: String
    var password: String
    
    init(adressingName: String, email: String, password: String, id: String? = "" ) {
        self.adressingName = adressingName
        self.email = email
        self.password = password
        self._id = id!
    }
    
    required init(coder aDecoder: NSCoder) {
        _id = (aDecoder.decodeObject(forKey: "id") as? String)!
        adressingName = aDecoder.decodeObject(forKey: "adressingName") as! String
        email = aDecoder.decodeObject(forKey: "email") as! String
        password = aDecoder.decodeObject(forKey: "password") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_id, forKey: "id")
        aCoder.encode(adressingName, forKey: "adressingName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
    }
}
