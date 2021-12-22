//
//  FollowersVC.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/21/21.
//

import UIKit

class FollowersVC: UIViewController {
    
    var userName: String!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getFollowers()
        configureCollectionView()
       
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
                print(followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, button: "Ok")
                //Pop back to Search if error
                DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
              }
            }
        }
    }
}
