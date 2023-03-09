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
        bindUI()
        AppDelegate.sharedAppDelegate.coreDataStack.resetData()
        
    }
    
    private func bindUI() {
        userIdTextfield.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        loginButton.isEnabled = viewModel.isLoginEnabled
        loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped(_ button: UIButton) {
        viewModel.loginAPI(userID: userIdTextfield.text ?? "0"){ [weak self] data in
            switch data {
            case .success(let post) :
                DispatchQueue.main.async {
                    self?.UpdateUIforLogin(post: post.count )
                }
                
            case .failure( _):
                self?.showAlert(title: Constants.errorTitle, message: Constants.InvalidUser)
                
            }
        }
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
    
    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.userID = textField.text ?? ""
        loginButton.isEnabled = viewModel.isLoginEnabled
    }
    
}


