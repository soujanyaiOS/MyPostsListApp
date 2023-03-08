//
//  FavoriteTableViewCell.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 07/03/23.
//


import UIKit
import CoreData

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    class var identifier: String { return String(describing: FavoriteTableViewCell.self)}
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)}
    
    var cellViewModel: FavoriteCellViewModel? {
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
