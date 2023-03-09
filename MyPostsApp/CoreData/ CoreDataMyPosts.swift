//
//   CoreDataMyPosts.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 06/03/23.
//


import CoreData

class CoreDataMyPostsStack {
    
    // MARK: - Properties
    
    private let modelName: String
    
    // MARK: - Initialization
    
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
    
    // MARK: - Core Data stack
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to find data model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to load data model")
        }
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let storeURL = documentsURL.appendingPathComponent("\(self.modelName).sqlite")
        
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true,
                                 NSInferMappingModelAutomaticallyOption: true]
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: storeURL,
                                                              options: options)
        } catch {
            fatalError("Unable to add persistent store")
        }
        
        return persistentStoreCoordinator
    }()
    
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
    
    func resetData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostsEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(batchDeleteRequest)
        } catch let error as NSError {
            
            print("Could not delete data: \(error)")
        }
    }
    
    func saveToFavourites(cellViewModel : PostsDataModel) {
        let newFavourite = PostsEntity(context: managedContext)
        newFavourite.setValue(cellViewModel.id, forKey: "id")
        newFavourite.setValue(cellViewModel.title, forKey: "title")
        newFavourite.setValue(cellViewModel.userId, forKey: "userId")
        newFavourite.setValue(cellViewModel.body, forKey: "body")
        do {
            debugPrint("Data saved")
            try managedContext.save()
        } catch let error as NSError {
            debugPrint("\(error)")
        }
        
        
    }
}




