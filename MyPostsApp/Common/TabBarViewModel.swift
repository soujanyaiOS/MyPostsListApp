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
    
    var childViewModels: [ChildViewModel] {
        return [
            ChildViewModel(title: "Home", image: UIImage(systemName: "house")),
            ChildViewModel(title: "Favourites", image: UIImage(systemName: "heart.fill"))
           
        ]
    }
    
    lazy var childViewControllers :[UIViewController] = {
        return [VCinst(name: "PostsViewController"),VCinst(name: "FavoritesViewController")]
    }()

    func VCinst(name:String) -> UIViewController {
           return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: name)
    }
    
    var selectedIndex: Int {
        return 0
    }
}


