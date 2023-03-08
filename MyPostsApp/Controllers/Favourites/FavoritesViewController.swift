//
//  FavoritesViewController.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 04/03/23.
//

import UIKit
import CoreData

class FavoritesViewController: BaseViewController {
    
    
    lazy var viewModel = {
        FavouritesViewModel()
    }()
    @IBOutlet weak var ListTableView: UITableView!
    @IBOutlet weak var NoRceordsLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        loadTable()
        initViewModel()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultNavigationBar(Constants.Favourites)
    }
    
    func loadTable() {
        ListTableView.register(FavoriteTableViewCell.nib, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
    }
    
    func initViewModel() {
        viewModel.getFavourites()
        viewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.ListTableView.reloadData()
            }
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as? FavoriteTableViewCell else {
            fatalError(Constants.XibError)
        }
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController: CommentsViewController = UIStoryboard.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        self.present(viewController, animated: false, completion: nil)
    }
    
}


