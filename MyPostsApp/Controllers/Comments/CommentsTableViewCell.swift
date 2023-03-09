//
//  CommentsTableViewCell.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 09/03/23.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: CommentsTableViewCell.self)}
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)}
    let userNameLabel = MyLabel()
    let titleLabel = MyLabel()
    let bodyLabel = MyLabel()
    
    lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        [self.userNameLabel,
         self.titleLabel,
         self.bodyLabel].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    var cellViewModel: CommentsDataModel? {
        didSet {
            userNameLabel.text = cellViewModel?.email
            titleLabel.text = cellViewModel?.name
            bodyLabel.text = cellViewModel?.body
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = .white
        
        self.userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.contentView.addSubview(detailsStackView)
        detailsStackView.anchor(top: self.contentView.topAnchor, left: self.contentView.leadingAnchor, right: self.contentView.trailingAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16, bottom: self.contentView.bottomAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
