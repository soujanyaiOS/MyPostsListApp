//
//  LoginNetworkManager.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 08/03/23.
//

import Foundation


protocol  LoginNetworkManagerProtocal {
    func login(userId: String ,completion: @escaping(Result<[Post],Error>) -> Void)
}

class LoginNetworkManager:  LoginNetworkManagerProtocal {
    
    
    
    func login(userId: String, completion: @escaping (Result<[Post], Error>) -> Void) {
        let endpoint = APIEndpoint.login(userId: userId)
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        request.allHTTPHeaderFields = endpoint.headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode([Post].self, from: data)
                    if result.count > 0 {
                        let defaults = UserDefaults.standard
                        defaults.set(userId, forKey: "userID")
                        defaults.synchronize()
                    }
                    
                    completion(.success(result))
                }
                catch { }
                
            }
        }.resume()
    }
}
