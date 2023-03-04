//
//  TabBarViewModel.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 04/03/23.
//

import Foundation
import UIKit

class TabBarViewModel {
    
    struct ChildViewModel {
        let title: String
        let image: UIImage?
    }
    
    let childViewControllers = [
           PostsViewController(),
           FavoritesViewController()
       ]
    
    var childViewModels: [ChildViewModel] {
        return [
            ChildViewModel(title: "Home", image: UIImage(systemName: "house")),
            ChildViewModel(title: "Favourites", image: UIImage(systemName: "heart.fill"))
           
        ]
    }
    
    var selectedIndex: Int {
        return 0
    }
}
