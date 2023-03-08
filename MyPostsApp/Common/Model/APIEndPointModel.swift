//
//  APIEndPointModel.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 08/03/23.
//

import Foundation

enum APIEndpoint {
    case login(userId: String)
    case getPosts(userId: Int)
    
    var url: URL {
        switch self {
        case .login(let userId):
            let urlString = "https://jsonplaceholder.typicode.com/posts?userId=\(userId)"
            return URL(string: urlString)!
            
        case .getPosts(let userId):
            let urlString = "https://jsonplaceholder.typicode.com/posts?userId=\(userId)"
            return URL(string: urlString)!
        }
    }
    
    var httpMethod: String {
        switch self {
        case .login:
            return "GET"
            
        case .getPosts:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

