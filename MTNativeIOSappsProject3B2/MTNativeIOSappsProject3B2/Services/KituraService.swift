//
//  KituraService.swift
//  MTNativeIOSappsProject3B2
//
//  Created by Matthias Tison on 19/12/2017.
//  Copyright © 2017 Matthias Tison. All rights reserved.
//

import KituraKit

class KituraService {
    
    private init() {}
    static let http = KituraService()
    
    private let db = KituraKit(baseURL: "http://localhost:8080/api/")!
    
    func getUsers(completion: @escaping ([User]?) -> Void) {
        db.get("users") {
            (users: [User]?, error: RequestError?) in
            if let error = error {
                print("Error while loading users: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion(users)
            }
        }
    }
    
    func create(_ user: User) {
        db.post("users", data: user) {
            (result: User?, error: RequestError?) in
            if let error = error {
                print("Error while creating the user \(user.email): \(error.localizedDescription)")
            }
        }
    }
    
    func update(withId _id: String,to user: User) {
        db.put("users", identifier: _id, data: user) {
            (result: User?, error: RequestError?) in
            if let error = error {
                print("Error while updating the user \(user.email): \(error.localizedDescription)")
            }
        }
    }
    
    func delete(withId _id: String) {
        db.delete("users", identifier: _id) {
            (error: RequestError?) in
            if let error = error {
                print("Error while deleting the user with id \(_id): \(error.localizedDescription)")
            }
        }
    }
}
