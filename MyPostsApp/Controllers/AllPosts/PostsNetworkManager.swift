//
//  PostsNetworkManager.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 05/03/23.
//

import Foundation

class MockPostApiService: PostsNetworkManagerProtocal {
   

    func  getPost(userId: Int ,completion: @escaping(Result<[Post],Error>) -> Void)  {
           
        let post1 = Post(userID: 1, id: 1, title: "Mock Post", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")

        let post2 = Post(userID: 1, id: 12, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")

        let posts = [post1, post2]

     
            completion(.success(posts))
       
          
        }
    

}

protocol  PostsNetworkManagerProtocal {
    func getPost(userId: Int ,completion: @escaping(Result<[Post],Error>) -> Void)
}

class PostsNetworkManager:  PostsNetworkManagerProtocal {
    
    func getPost(userId: Int, completion: @escaping (Result<[Post], Error>) -> Void) {
        let endpoint = APIEndpoint.getPosts(userId: userId)
        
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
                    
                    completion(.success(result))
                }
                catch { }
                
            }
        }.resume()
    }
}
