//
//  FollowersVC.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/21/21.
//

import UIKit

class FollowersVC: UIViewController {
    
    enum Section{
        case main
    }
    
    var userName: String!
    var followers: [Followers] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Followers>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getFollowers()
        configureCollectionView()
        configureDataSource()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureCollectionFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemCyan
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureCollectionFlowLayout() -> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minimumSpacing:CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getFollowers(){
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
           
            switch result{
            case .success(let followers):
                self.followers = followers
                self.updateData()
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, button: "Ok")
                //Pop back to Search if error
                DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
              }
            }
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Followers>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            return cell
        })
    }
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Followers>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
}
