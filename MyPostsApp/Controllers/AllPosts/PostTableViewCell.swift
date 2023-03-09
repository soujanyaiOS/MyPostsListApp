//
//  PostTableViewCell.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 05/03/23.
//

import UIKit
import CoreData
protocol PostTableViewCellProtocal: AnyObject {
    func reloadData()
}
class PostTableViewCell: UITableViewCell {
    weak var delegate: PostTableViewCellProtocal?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    var favObject : FavouriteRepository?
    
    class var identifier: String { return String(describing: PostTableViewCell.self)}
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)}
    
    var cellViewModel: PostsDataModel? {
        didSet {
            titleLabel.text = cellViewModel?.title
            bodyLabel.text = cellViewModel?.body
            if AppDelegate.sharedAppDelegate.coreDataStack.checkIfRecordExists(withID: cellViewModel?.id ?? 0) {
                favButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
            else{
                favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
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
    
    ///Save to Favourites
    @IBAction func addToFavouritesAction(_ sender: UIButton) {
        
        if AppDelegate.sharedAppDelegate.coreDataStack.checkIfRecordExists(withID: cellViewModel?.id ?? 0) {
            if let cellModel = cellViewModel {
            AppDelegate.sharedAppDelegate.coreDataStack.saveToFavourites(cellViewModel: cellModel)
            delegate?.reloadData()
            }
        }
        else {
            print("Record ID \(self.cellViewModel?.id ?? 0)  exists!")
        }
    }
}

