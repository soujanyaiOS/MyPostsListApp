//
//  LoginViewController.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 04/03/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userIdTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        bindUI()
        AppDelegate.sharedAppDelegate.coreDataStack.resetData()
    }
    
    private func bindUI() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
    }
    
    func initViewModel() {
        
        viewModel.reloadView = {[weak self] in
            DispatchQueue.main.async {
                self?.UpdateUIforLogin(post: self?.viewModel.posts.count ?? 0)
            }
        }
        
        viewModel.errorHandler = { [weak self] _ in
            self?.showAlert(title: Constants.errorTitle, message: Constants.InvalidUser)
        }
    }
    
    
    @objc private func loginButtonTapped(_ button: UIButton) {
        viewModel.loginAPI(userID: userIdTextfield.text ?? "0")
    }
    
    func UpdateUIforLogin(post: Int) {
        if post > 0 {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            sceneDelegate.windowCoordinator.presentTabBarController()
        }
        else{
            showAlert(title: "", message: Constants.noDataAvailable)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
