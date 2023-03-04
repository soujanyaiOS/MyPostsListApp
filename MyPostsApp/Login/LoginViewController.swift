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
    }
    
    private func bindUI() {
        userIdTextfield.addTarget(self, action: #selector(userIDTextFieldDidChange(_:)), for: .editingChanged)
        
        loginButton.isEnabled = viewModel.isLoginEnabled
        loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func userIDTextFieldDidChange(_ textField: UITextField) {
        viewModel.userID = textField.text ?? ""
        //remove later after dynamica validation
        loginButton.isEnabled = true//viewModel.isLoginEnabled
    }
    
    
    @objc private func loginButtonTapped(_ button: UIButton) {
        viewModel.login { [weak self] isSuccess in
            DispatchQueue.main.async {
                if isSuccess {
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                    //                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    //                    appdelegate.windowCoordinator.presentTabBarController()
                    sceneDelegate.windowCoordinator.presentTabBarController()
                    //                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    //                    appdelegate.windowCoordinator = WindowCoordinator(window: appdelegate.window ?? UIWindow())
                    //                    appdelegate.windowCoordinator.presentTabBarController()
                } else {
                    let alert = UIAlertController(title: "Error", message: "Invalid UserID", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
