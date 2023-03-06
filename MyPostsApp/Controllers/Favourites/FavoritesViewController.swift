//
//  FavoritesViewController.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 04/03/23.
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    lazy var viewModel = {
        PostViewModel()
    }()
    @IBOutlet weak var ListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultNavigationBar("Favourites")
        loadTable()
        initViewModel()
    }
    func loadTable() {
        
        ListTableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.identifier)
        ListTableView.reloadData()
    }
    
    func initViewModel() {
        viewModel.getPosts(userID: 1)
        viewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.ListTableView.reloadData()
            }
        }
    }
    
    
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.postCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
            fatalError("xib does not exists")
        }
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CommentsViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcs = storyboard.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        vcs.modalPresentationStyle = .fullScreen
        self.present(vcs, animated: false, completion: nil)
    }
    
    
    
}


