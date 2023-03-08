//
//  ExtensionFile.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 08/03/23.
//

import UIKit
extension UIStoryboard {
    static func instantiateViewController<T: UIViewController>(withIdentifier identifier: String, fromStoryboardNamed storyboardName: String = "Main") -> T? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
}

enum ButtonImage {
    case logout   
    case disabled
    
    var image: UIImage? {
        switch self {
        case .logout:
            return UIImage(named: "logout.png")
       
        case .disabled:
            return UIImage(named: "disabledImageName")
        }
    }
}
