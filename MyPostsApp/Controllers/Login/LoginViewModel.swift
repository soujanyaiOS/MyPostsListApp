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
        return !userID.isEmpty
    }
    
    private var loginApiService: LoginNetworkManagerProtocal
    
    init(loginApiService: LoginNetworkManagerProtocal = LoginNetworkManager()) {
        self.loginApiService = loginApiService
    }
    
    
    func loginAPI(userID: String,completion: @escaping(Result<[Post],Error>) -> Void) {
        loginApiService.login(userId: userID) { data in
            switch data {
            case .success(let post):
                completion(.success(post))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}


