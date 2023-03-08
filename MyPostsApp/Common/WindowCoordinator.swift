//
//  WindowCoordinator.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 04/03/23.
//

import Foundation
import UIKit

class WindowCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func presentTabBarController() {
        let tabBarController = UITabBarController()
        let viewModel = TabBarViewModel()
        
        var viewControllers = [UIViewController]()
        for (index,childViewModel) in viewModel.childViewControllers.enumerated() {
            let childViewController = childViewModel
            let childTabModel = viewModel.childViewModels[index]
            childViewController.tabBarItem = UITabBarItem(title: childTabModel.title, image: childTabModel.image, selectedImage: nil)
            viewControllers.append(childViewController)
            
        }
        
        tabBarController.viewControllers = viewControllers
        tabBarController.selectedIndex = viewModel.selectedIndex
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func presentLoginViewController() {
        let loginViewController: LoginViewController? = UIStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
        loginViewController?.viewModel = LoginViewModel()
        
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }

}
