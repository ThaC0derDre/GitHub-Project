//
//  GFButton.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/19/21.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init (backgroundColor: UIColor, title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    
    private func configure(){
        layer.cornerRadius    = 10
        //not needed since white is default
        setTitleColor(.white, for: .normal)
        titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
