//
//  BaseViewController.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 05/03/23.
//

import UIKit

class BaseViewController: UIViewController {

  //  var ListTableView = UITableView()
    var label = UILabel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }

    public func setDefaultNavigationBar(_ title: String) {
        label.frame = CGRect(x: 0, y: 60, width: self.view.frame.width, height: 44)
        label.text = title
        label.textColor = .white
        label.textAlignment = .center
        self.view.addSubview(label)
    }
    
    func setNavigationBarAppearence(withBackgroundColor color: UIColor) {
        // Make the navigation bar's title with red text.
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = color
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
            navigationItem.compactAppearance = appearance // For iPhone small navigation bar in landscape.
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
