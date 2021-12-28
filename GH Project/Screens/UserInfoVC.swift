//
//  UserInfoVC.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/27/21.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            switch result{
            case .success(let user):
                print(user)
            case .failure(let error):
                self?.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, button: "Ok")
            }
        }
    }
   @objc func dismissVC(){
        dismiss(animated: true)
    }
}
