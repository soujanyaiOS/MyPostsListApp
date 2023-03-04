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

            
            let cheil = viewModel.childViewModels[index]
                    
            childViewController.tabBarItem = UITabBarItem(title: cheil.title, image: cheil.image, selectedImage: nil)
            viewControllers.append(childViewController)
            

        }
        
        tabBarController.viewControllers = viewControllers
        tabBarController.selectedIndex = viewModel.selectedIndex
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func presentLoginViewController() {
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginViewController.viewModel = LoginViewModel()
        
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
}
