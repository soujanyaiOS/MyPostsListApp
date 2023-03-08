//
//  LoginViewModel.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 04/03/23.
//

import Foundation


class LoginViewModel {
    
    var reloadView: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    var userID = ""
//    var isLoginEnabled: Bool {
//        return  userID != ""
//    }
    
    var posts = [Post](){
        didSet {
            reloadView?()
        }
    }
    
   
    private var loginApiService: LoginNetworkManagerProtocal
    
    init(loginApiService: LoginNetworkManagerProtocal = LoginNetworkManager()) {
        self.loginApiService = loginApiService
    }
    
    
    func loginAPI(userID: String) {
        loginApiService.login(userId: userID) { [weak self] data in
            switch data {
            case .success(let post):
                print(post)
                self?.posts = post
               
            case .failure(let error):
                self?.errorHandler?(error)
            }
        }
    }
    
    
//    func login(userID: String , completion: @escaping (Bool) -> Void) {
//
//        if let url =  URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userID)") {
//            let urlSession =    URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if let error = error {
//                    completion(false)
//                }
//                
//                if let data = data {
//                    do {
//                        let result = try JSONDecoder().decode([Post].self, from: data)
//                        if result.count > 0 {
//                            let defaults = UserDefaults.standard
//                            defaults.set(userID, forKey: "userID")
//                            defaults.synchronize()
//                            completion(true)
//                        }
//                        else {
//                            completion(false)
//                        }
//                    }
//                    catch { }
//                    
//                }
//            }
//            urlSession.resume()
//        }
//        
//        
//    }
    
    
   
}


