//
//  PostsEntity+CoreDataProperties.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 07/03/23.
//
//

import Foundation
import CoreData


extension PostsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostsEntity> {
        return NSFetchRequest<PostsEntity>(entityName: "PostsEntity")
    }

    @NSManaged public var userId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var body: String?

}

extension PostsEntity : Identifiable {

}
