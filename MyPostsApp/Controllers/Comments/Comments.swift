//
//  Comments.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 09/03/23.
//

import Foundation
struct Comment: Decodable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

typealias Comments = [Comment]
