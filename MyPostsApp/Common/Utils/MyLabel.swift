//
//  MyLabel.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 09/03/23.
//

import UIKit
class MyLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.textAlignment = .left
        self.font = UIFont.systemFont(ofSize: 15)
        self.textColor = UIColor.black
        self.numberOfLines = 0        
    }
    
}
