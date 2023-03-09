//
//  CommnetsViewmodel.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 09/03/23.
//

import Foundation

struct CommentsDataModel {
    var id: Int
    var body: String
    var postID: Int
    var name: String
    var email: String
}

class CommnetsViewmodel: NSObject {
    var reloadTableView: (() -> Void)?
    var comments = Comments()
    
    var commnetCellViewModels = [CommentsDataModel](){
        didSet {
            reloadTableView?()
        }
    }
    
    var postID: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "userID")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userID")
        }
    }
    private var commentApiService: CommnetsNetworkManagerProtocal

    init(commentApiService: CommnetsNetworkManagerProtocal = CommnetsNetworkManager()) {
        self.commentApiService = commentApiService
    }
    
    init(apiService: CommnetsNetworkManagerProtocal) {
           self.commentApiService = apiService
       }
    
    func fetchData(commentsData: Comments) {
        self.comments = commentsData
        var vms = [CommentsDataModel]()
        for comment in commentsData {
            vms.append(createCellModel(post: comment))
        }
        commnetCellViewModels = vms
    }
    
    func createCellModel(post: Comment) -> CommentsDataModel {
        let idValue = post.id
        let email = post.email
        let body = post.body
        let postID = post.postID
        let name = post.name
        return CommentsDataModel(id: idValue, body: body, postID: postID, name: name, email: email)
    }
    
    func getComments(postID: Int) {
        commentApiService.getComments(postID: postID) { data in
            switch data {
            case .success(let comment):
                print(comment)
                self.fetchData(commentsData: comment)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CommentsDataModel {
        return commnetCellViewModels[indexPath.row]
    }
    
}
