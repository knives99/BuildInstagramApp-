//
//  AuthManager.swift
//  BuildInstagramApp
//
//  Created by Bryan on 2021/10/26.
//

import Foundation
import FirebaseAuth

public class Authmanager{
    
    static let shared = Authmanager()
    
    public func registerNewUser(username:String,email:String,password:String,completion: @escaping(Bool)->Void){
        /*
         - check if usermae is available
         -  check if email is availabla

         */
        DatabaseManeger.shared.canCreateNewUser(with: email, username: username) { canCreat in
            if canCreat{
                /*
                 - create account
                 - insert account to data base
                 */
                Auth.auth().createUser(withEmail: email, password: password) { Result, Error in
                    guard Error == nil, Result != nil else{
                        // Firebase auth could not create Acoount
                        completion(false)
                        return}
                    // insert into Database
                    DatabaseManeger.shared.insertNewUser(with: email, username: username) { success in
                        if success{
                            completion(true)
                        }else{
                            //Failed to insert to database
                            completion(false)
                        }
                    }
                }
            }else{
                //Either userName or email does not exsit
                completion(false)
            }
        }
        
    }
    
    public func loginUser(username:String?,email:String?,password:String?,completion:@escaping ((Bool) -> Void)){
        guard let password = password else {
            return
        }
        if let  email = email{
            //email Login
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil ,error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username{
            //userName login
            print(username)
            
        }
    }
    /// Attempt to log out Firebase User
    public func logOut(completion:(Bool)->Void){
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }catch{
            completion(false)
            print(error)
            return
        }
   
    }

    
}
