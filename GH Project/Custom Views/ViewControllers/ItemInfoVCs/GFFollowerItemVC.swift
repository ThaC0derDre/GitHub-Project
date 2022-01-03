//
//  GFFollowerItemVC.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/29/21.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure(){
        itemInfoView1.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoView2.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backGroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
