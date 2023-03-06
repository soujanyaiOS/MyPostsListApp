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
}


class PostViewModel: NSObject {
    var reloadTableView: (() -> Void)?
    var posts = Posts()
    
    var postCellViewModels = [PostCellViewModel](){
        didSet {
            reloadTableView?()
        }
    }
    
    
    private var postApiService: PostsNetworkManagerProtocal
    
    init(postApiService: PostsNetworkManagerProtocal = PostsNetworkManager()) {
        self.postApiService = postApiService
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
        let userId = post.userID
        let title = post.title
        let body = post.body
        return PostCellViewModel(id: userId, title: title, body: body)
    }
    
    func getPosts(userID: Int) {
        postApiService.getPost(userID: userID) { data in
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
