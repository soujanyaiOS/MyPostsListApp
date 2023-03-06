//
//  PostsNetworkManager.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 05/03/23.
//

import Foundation


protocol  PostsNetworkManagerProtocal {
    func getPost(userID: Int ,completion: @escaping(Result<[Post],Error>) -> Void)
}

class PostsNetworkManager:  PostsNetworkManagerProtocal {
    
    func getPost(userID: Int , completion: @escaping(Result<[Post],Error>) -> Void) {
        if let url =  URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userID)") {
            let urlSession =    URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    
                    do {
                        let result = try JSONDecoder().decode([Post].self, from: data)
                        completion(.success(result))
                     }
                      catch { }
                 
                }
            }
             urlSession.resume()
        }
    }
}
