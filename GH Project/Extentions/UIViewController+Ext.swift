//
//  UIViewController+Ext.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/21/21.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, button: String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonLabel: button)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle   = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha           = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView()
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.style = .large
        activityIndicator.startAnimating()
    }
}
