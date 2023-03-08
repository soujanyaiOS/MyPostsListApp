//
//  PostViewModel.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 05/03/23.
//

import Foundation

struct PostCellViewModel {
    var id: Int
    var title: String
    var body: String
    var userId: Int
    
}


class PostViewModel: NSObject {
    var reloadTableView: (() -> Void)?
    var posts = Posts()
    
    var postCellViewModels = [PostCellViewModel](){
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
        var vms = [PostCellViewModel]()
        for post in posts {
            vms.append(createCellModel(post: post))
        }
        postCellViewModels = vms
    }
    
    func createCellModel(post: Post) -> PostCellViewModel {
        let idValue = post.id
        let title = post.title
        let body = post.body
        let userID = post.userID
        return PostCellViewModel(id: idValue, title: title, body: body, userId: userID)
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
    
    func getCellViewModel(at indexPath: IndexPath) -> PostCellViewModel {
        return postCellViewModels[indexPath.row]
    }
    
}
