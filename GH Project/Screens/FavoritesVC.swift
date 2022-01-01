//
//  FavoritesVC.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/19/21.
//

import UIKit

class FavoritesVC: UIViewController {

    let tableView               = UITableView()
    var favorites:[Followers]   = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    func configureViewController(){
        
        title                       = "Favorites"
        tableView.backgroundColor   = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        
        view.addSubview(tableView)
        tableView.frame      = view.bounds
        tableView.rowHeight  = 80
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
    }
}
extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseID) as! FavoritesCell
        let favorite = favorites[indexPath.row]
        cell.set(favorites: favorite)
        return cell
    }
}
