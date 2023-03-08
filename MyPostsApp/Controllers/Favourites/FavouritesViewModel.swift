//
//  FavouritesViewModel.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 07/03/23.
//

import Foundation
import CoreData

struct FavoriteCellViewModel {
    var id: Int
    var title: String
    var body: String
    var userId: Int64
}


class FavouritesViewModel: NSObject {
    var reloadTableView: (() -> Void)?
    var favouritesArray: [PostsEntity] = []
    
    var cellViewModels = [FavoriteCellViewModel](){
        didSet {
            reloadTableView?()
        }
    }
   
    func getFavourites() {
        let favouriteObjFetch: NSFetchRequest<PostsEntity> = PostsEntity.fetchRequest()
        let sortById = NSSortDescriptor(key: "id", ascending: false)
        favouriteObjFetch.sortDescriptors = [sortById]
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(favouriteObjFetch)
            favouritesArray = results
            fetchData(posts: favouritesArray)
            
        } catch let error as NSError {
            debugPrint("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    func fetchData(posts: [PostsEntity]) {
        self.favouritesArray = posts
        var vms = [FavoriteCellViewModel]()
        for post in posts {
            vms.append(createCellModel(post: post))
        }
        cellViewModels = vms
    }
    
    func createCellModel(post: PostsEntity) -> FavoriteCellViewModel {
        let idValue = post.id
        let title = post.title ?? ""
        let body = post.body ?? ""
        let userID = post.userId
        return FavoriteCellViewModel(id: Int(idValue), title: title, body: body, userId: userID)
    }
    
  
    func getCellViewModel(at indexPath: IndexPath) -> FavoriteCellViewModel {
            return cellViewModels[indexPath.row]
        }
    
}
