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
            ChildViewModel(title: Constants.ALLTab, image: ButtonImage.listTab.image),
            ChildViewModel(title: Constants.FavouriteTab, image:ButtonImage.favouritesTab.image)
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


