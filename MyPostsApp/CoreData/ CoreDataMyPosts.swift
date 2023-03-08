//
//   CoreDataMyPosts.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 06/03/23.
//


import CoreData
class CoreDataMyPosts {
    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

 
    
    func checkIfRecordExists(withID id: Int) -> Bool {
        let fetchRequest: NSFetchRequest<PostsEntity> = PostsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        do {
            let matchingEntities = try managedContext.fetch(fetchRequest)
            return matchingEntities.isEmpty
        } catch {
            print("Error checking if record exists: \(error)")
            return false
        }
    }
    
    
    
//    func saveToFavourites(cellViewModel : PostCellViewModel, completion:@escaping((Result<Bool,Error>) ->Void)) {
    func saveToFavourites(cellViewModel : PostCellViewModel?) {
        let newFavourite = PostsEntity(context: managedContext)
        
        newFavourite.setValue(cellViewModel?.id, forKey: "id")
        newFavourite.setValue(cellViewModel?.title, forKey: "title")
        newFavourite.setValue(cellViewModel?.userId, forKey: "userId")
        newFavourite.setValue(cellViewModel?.body, forKey: "body")
        do {
            debugPrint("Data saved")
            try managedContext.save()
           // completion(.success(true))
           
        } catch let error as NSError {
            debugPrint("error")
           
        }
    }
    
    func resetData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostsEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            // Execute the batch delete request
            try managedContext.execute(batchDeleteRequest)
        } catch let error as NSError {
            // Handle the error
            print("Could not delete data: \(error)")
        }
    }
}
