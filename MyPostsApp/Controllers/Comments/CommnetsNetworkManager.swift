//
//  CommnetsNetworkManager.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 09/03/23.
//

import Foundation
import SwiftLoader

class MockCommentApiService: CommnetsNetworkManagerProtocal {
    func getComments(postID: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "Comments", withExtension: "json") {
            
           
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Comment].self, from: data)
                print(jsonData)
                completion(.success(jsonData))
            } catch {
                print("error decoding")
            }
        }
    }
}

protocol  CommnetsNetworkManagerProtocal {
    func getComments(postID: Int ,completion: @escaping(Result<[Comment],Error>) -> Void)
}

class CommnetsNetworkManager:  CommnetsNetworkManagerProtocal {
    
    func getComments(postID: Int ,completion: @escaping(Result<[Comment],Error>) -> Void) {
        SwiftLoader.show(animated: true)
        let endpoint = APIEndpoint.getComments(postID: postID)
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        request.allHTTPHeaderFields = endpoint.headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            SwiftLoader.hide()
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode([Comment].self, from: data)
                    print(result)
                    completion(.success(result))
                }
                catch { }
                
            }
        }.resume()
    }
}
