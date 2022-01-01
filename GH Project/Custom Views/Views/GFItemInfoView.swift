//
//  GFItemInfoView.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/29/21.
//

import UIKit

enum ItemInfoType{ case repos, gists, followers, following }

class GFItemInfoView: UIView {

    var symbolImageView = UIImageView()
    var titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    var countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
        
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int ){
        switch itemInfoType {
    case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text       = "Public repos"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text       = "Public gists"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text       = "Followers"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text       = "Following"
        }
        countLabel.text           = String(count)
    }
    
}
