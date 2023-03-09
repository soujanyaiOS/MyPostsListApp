//
//  FavouriteRepository.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 08/03/23.
//

import Foundation
import CoreData
class FavouriteRepository {
//    let coreDataStack: CoreDataMyPostsStack
//    
//   
//    init(coreDataStack: CoreDataMyPostsStack) {
//        self.coreDataStack = coreDataStack
//    }

    func saveFavourite(_ favourite: PostsDataModel) {
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let newFavourite = PostsEntity(context: AppDelegate.sharedAppDelegate.coreDataStack.managedContext)
        newFavourite.setValue(favourite.id, forKey: "id")
        newFavourite.setValue(favourite.title, forKey: "title")
        newFavourite.setValue(favourite.userId, forKey: "userId")
        newFavourite.setValue(favourite.body, forKey: "body")
        do {
            debugPrint("Data saved")
            try context.save()
        } catch let error as NSError {
            debugPrint("\(error)")
        }
    }
    
    func fetchFavourites(completion: @escaping (Result<[PostsEntity], Error>) -> Void) {
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let favouriteObjFetch: NSFetchRequest<PostsEntity> = PostsEntity.fetchRequest()
        let sortById = NSSortDescriptor(key: "id", ascending: false)
        favouriteObjFetch.sortDescriptors = [sortById]
        do {
            let results = try managedContext.fetch(favouriteObjFetch)
             completion(.success(results))
      
        } catch let error as NSError {
        completion(.failure(error))
        
        }
    }
}
