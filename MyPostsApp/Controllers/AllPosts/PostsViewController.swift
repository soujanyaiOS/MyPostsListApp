//
//  PostsViewController.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 04/03/23.
//

import UIKit

class PostsViewController: BaseViewController {
    @IBOutlet weak var ListTableView: UITableView!
    lazy var viewModel = {
        PostViewModel()
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        loadTable()
        initViewModel()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultNavigationBar(Constants.MyPostTitle)
    }
    
    func loadTable() {
        ListTableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.identifier)
        ListTableView.reloadData()
    }
    
    func initViewModel() {
        viewModel.getPosts(userID: viewModel.userID ?? 1)
        viewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.ListTableView.reloadData()
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.postCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
            fatalError(Constants.XibError)
        }
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcs = storyboard.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        self.present(vcs, animated: false, completion: nil)
        
    }
    
}

extension PostsViewController: PostTableViewCellProtocal {
    func reloadData() {
        ListTableView.reloadData()
    }
}

