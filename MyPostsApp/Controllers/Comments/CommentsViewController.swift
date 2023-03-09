//
//  CommentsViewController.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 06/03/23.
//

import UIKit

class CommentsViewController: UIViewController {
    
    
    // MARK: - Properties
    var post: Post?
    lazy var viewModel = {
        CommnetsViewmodel()
    }()
    
    let myCommentsLbl = MyLabel()
    let userNameLabel = MyLabel()
    let titleLabel = MyLabel()
    let bodyLabel = MyLabel()
    
    
    // MARK: - UI Elements
    
//    let myCommentsLbl: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
//        label.numberOfLines = 0
//        label.textAlignment = .center
//
//        return label
//    }()
//
//
//
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//        label.numberOfLines = 0
//        label.backgroundColor = .yellow
//        return label
//    }()
//
//    let bodyLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.numberOfLines = 0
//        return label
//    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(CommentsTableViewCell.self, forCellReuseIdentifier: "CommentsTableViewCell")
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setData()
        setUIFont()
    }
    
    private func setUIFont() {
        myCommentsLbl.textAlignment = .center
        myCommentsLbl.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .brown
    }
    private func setData(){
        guard let post = post else { return }
        titleLabel.text = "Post Title : \(post.title)"
        bodyLabel.text = "Post Description : \(post.body)"
        myCommentsLbl.text = "My Comments"
        viewModel.getComments(postID: post.id)
        setupUI()
    }

    
    func initViewModel() {
 
        viewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
       
        
        view.addSubview(myCommentsLbl)
        myCommentsLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: myCommentsLbl.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, paddingTop:50, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(bodyLabel)
        bodyLabel.anchor(top: titleLabel.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(tableView)
        tableView.anchor(top: bodyLabel.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
}

// MARK: - UITableViewDataSource

extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

