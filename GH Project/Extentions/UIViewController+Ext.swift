//
//  UIViewController+Ext.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/21/21.
//

import UIKit
import SafariServices 

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, button: String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonLabel: button)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle   = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(with url:URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
