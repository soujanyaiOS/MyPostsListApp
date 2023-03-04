//
//  LoginViewModel.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 04/03/23.
//

import Foundation

class LoginViewModel {
    
    var userID = ""
  
    
    var isLoginEnabled: Bool {
        return  userID != ""
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        // Call the login API here and validate the response
        let isSuccess = true
        completion(isSuccess)
    }
}


