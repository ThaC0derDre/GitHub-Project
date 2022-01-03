//
//  FollowersVC.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/21/21.
//

import UIKit

protocol FollowersListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowersVC: GFDataLoadingVC {
    
    enum Section{case main}
    
    var userName: String!
    var followers: [Followers]         = []
    var filteredFollowers: [Followers] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Followers>!
    var page                           = 1
    var hasMoreFollowers               = true
    var isSearching                    = false
    var isLoadingFollowers             = false
    var lastScrollPosition: CGFloat    = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        confirgureSearchBar()
        configureCollectionView()
        getFollowers(username: userName, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        userName = username
        title    = username
        userName = username
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.configureCollectionFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate        = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func getFollowers(username: String, page: Int){
        isLoadingFollowers = true
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            self.stopLoadingView()
            
            switch result{
            case .success(let followers):
                self.updateUI(with: followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, button: "Ok")
                //Pop back to Search if error
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        isLoadingFollowers = false
    }
    
    
    func updateUI(with followers: [Followers]){
        if followers.count < 100 {self.hasMoreFollowers = false}
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty{
            let message = "This user has no followers. Maybe be the first?"
            DispatchQueue.main.async { self.showEmptyStateScreen(with: message, in: self.view) }
            return
        }
        self.updateData(with: self.followers)
    }
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Followers>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(followers: follower)
            return cell
        })
    }
    
    
    func confirgureSearchBar(){
        let searchController                    = UISearchController()
        searchController.searchBar.placeholder  = "Enter User Name"
        searchController.searchResultsUpdater   = self
        navigationItem.searchController         = searchController
    }
    
    
    func updateData(with followers:[Followers]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Followers>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    @objc func addButtonTapped(){
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            self.stopLoadingView()
            
            switch result {
            case .success(let user):
                self.addToFavorites(user: user)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Could not favorite this user", message: error.rawValue, button: "Ok")
            }
        }
        
    }
    
    
    func addToFavorites(user: User){
        let favorite = Followers(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                
                self.presentGFAlertOnMainThread(title: "Added to Favorites!", message: "Favorited users can be found in the 'Favorites' tab below", button: "Ok")
                return
            }
            self.presentGFAlertOnMainThread(title: "Could not favorite user", message: error.rawValue, button: "Ok.")
        }
    }
}


extension FollowersVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        if offsetY > contentHeight - height{
            guard hasMoreFollowers, !isLoadingFollowers else {return}
            page += 1
            getFollowers(username: userName, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentArray  = isSearching ? filteredFollowers : followers
        let followers     = currentArray[indexPath.item]
        let destVC        = UserInfoVC()
        destVC.userName   = followers.login
        destVC.delegate   = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


extension FollowersVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(with: followers)
            isSearching = false
            return
        }
        isSearching = true
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(with: filteredFollowers)
    }
}


extension FollowersVC: FollowersListVCDelegate {
    
    func didRequestFollowers(for username: String) {
        userName         = username
        title            = username
        page             = 1
        hasMoreFollowers = true
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        if isSearching {
            navigationItem.searchController?.searchBar.text = ""
            navigationItem.searchController?.isActive       = false
            navigationItem.searchController?.dismiss(animated: false)
            isSearching      = false
        }
        getFollowers(username: username, page: page)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastScrollPosition = scrollView.contentOffset.y
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastScrollPosition < scrollView.contentOffset.y {
            navigationItem.hidesSearchBarWhenScrolling = true
        }else if lastScrollPosition > scrollView.contentOffset.y {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
}
