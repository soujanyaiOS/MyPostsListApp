//
//  PostViewModel.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 05/03/23.
//

import Foundation

struct PostsDataModel {
    var id: Int
    var title: String
    var body: String
    var userId: Int
    
}


class PostViewModel: NSObject {
    var reloadTableView: (() -> Void)?
    var posts = Posts()
    
    var postCellViewModels = [PostsDataModel](){
        didSet {
            reloadTableView?()
        }
    }
    
    var userID: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "userID") 
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userID") 
        }
    }
    private var postApiService: PostsNetworkManagerProtocal

    init(postApiService: PostsNetworkManagerProtocal = PostsNetworkManager()) {
        self.postApiService = postApiService
    }
    
    init(apiService: PostsNetworkManagerProtocal) {
           self.postApiService = apiService
       }
    
    func fetchData(posts: Posts) {
        self.posts = posts
        var vms = [PostsDataModel]()
        for post in posts {
            vms.append(createCellModel(post: post))
        }
        postCellViewModels = vms
    }
    
    func createCellModel(post: Post) -> PostsDataModel {
        let idValue = post.id
        let title = post.title
        let body = post.body
        let userID = post.userID
        return PostsDataModel(id: idValue, title: title, body: body, userId: userID)
    }
    
    func getPosts(userID: Int) {
        postApiService.getPost(userId: userID) { data in
            switch data {
            case .success(let post):
                print(post)
                self.fetchData(posts: post)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> PostsDataModel {
        return postCellViewModels[indexPath.row]
    }
    
}
