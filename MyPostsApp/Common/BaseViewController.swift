//
//  BaseViewController.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 05/03/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var logoutButton: UIButton = {
        let btn = UIButton()
        btn.setImage(ButtonImage.logout.image, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        setLogoutButton()
    }
    
    @objc func logout() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.windowCoordinator.presentLoginViewController()
    }
    
    private func setLogoutButton() {
        logoutButton.frame = CGRect(x: self.view.frame.width - 55, y: 45, width: 25, height: 25)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        self.view.addSubview(logoutButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public func setDefaultNavigationBar(_ title: String) {
        myLabel.frame = CGRect(x: 0, y: 40, width: self.view.frame.width, height: 44)
        myLabel.text = title
        self.view.addSubview(myLabel)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
}
