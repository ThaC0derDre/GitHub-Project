//
//  UIView+Ext.swift
//  GH Project
//
//  Created by Andres Gutierrez on 1/2/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...){
        for view in views { addSubview(view) }
    }
}
