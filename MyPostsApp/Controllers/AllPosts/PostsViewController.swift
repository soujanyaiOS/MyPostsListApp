//
//  PostsViewController.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 04/03/23.
//

import UIKit

class PostsViewController: BaseViewController {
    @IBOutlet weak var ListTableView: UITableView!
   // var ListTableView = UITableView()
    lazy var viewModel = {
        PostViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultNavigationBar("My Posts")
        loadTable()
        initViewModel()
      
        // Do any additional setup after loading the view.
    }
    
    func loadTable() {
//        ListTableView.translatesAutoresizingMaskIntoConstraints = false
//        ListTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
//        ListTableView.delegate = self
//        ListTableView.dataSource = self
//        ListTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
//        ListTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
//        ListTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
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

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
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
        
//        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
//        sceneDelegate.windowCoordinator.presentCommentViewController()
    }
    
    
    
}

