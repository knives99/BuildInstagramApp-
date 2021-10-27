//
//  DatabaseManager.swift
//  BuildInstagramApp
//
//  Created by Bryan on 2021/10/26.
//

import Foundation
import FirebaseDatabase
import UIKit

public class DatabaseManeger {
    
    static let shared = DatabaseManeger()
    private let database = Database.database().reference()
    
    //check if username and email is available
    // -pareamerters
    //      -email:String representing email
    //      -username:String representing username
    
    public func canCreateNewUser(with email:String,username:String,completion:(Bool)->Void){
        completion(true)
    }
    
    
    //Insers new user data to database
    // -pareamerters
    //      -email:String representing email
    //      -username:String representing username
    //      -completion: Async callback for result if database entry successed
    public func insertNewUser(with email:String,username:String,completion:@escaping(Bool)->Void){
        let emailUpload = email.safeDatabasrKey()
        database.child(emailUpload).setValue(["username":username]) { Error, _ in
            if Error == nil {
                //successed
                completion(true)
                return
            }else{
                //failed
                completion(false)
                return
            }
        }
    }
    

    
}
