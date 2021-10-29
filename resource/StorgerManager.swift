//
//  StorgerManager.swift
//  BuildInstagramApp
//
//  Created by Bryan on 2021/10/26.
//

import Foundation
import FirebaseStorage

public class StorageManager{
    
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    
   public enum IGStorageManagerError :Error{
        case failedToDownload
    }
    
    public func uploadUserPost(model:UserPost,completion:@escaping(Result<URL,Error>) -> Void){
        
    }
    
    public func downloadInage(with reference:String,completion:@escaping(Result<URL,IGStorageManagerError>) ->Void){
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error != nil else{
                
                return}
            
            completion(.success(url))
        }
    }
    
}
enum UserPostType {
    case photo,video
}

public struct UserPost{
    let postType : UserPostType
}
