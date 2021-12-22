//
//  GFContainerVC.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/21/21.
//

import UIKit

class GFContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius   = 16
        layer.borderWidth    = 2
        backgroundColor      = .systemBackground
        layer.borderColor    = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
