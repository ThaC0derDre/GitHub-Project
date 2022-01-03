//
//  GFRepoItemVC.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/29/21.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure(){
        itemInfoView1.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoView2.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backGroundColor: .systemPurple, title: "Github Profile")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
