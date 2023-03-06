//
//  PostTableViewCell.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 05/03/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    class var identifier: String { return String(describing: PostTableViewCell.self)}
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)}
    
    var cellViewModel: PostCellViewModel? {
        didSet {
            titleLabel.text = cellViewModel?.title
            bodyLabel.text = cellViewModel?.body
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func initView() {
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        bodyLabel.text = nil
    }
    
  
    
}
