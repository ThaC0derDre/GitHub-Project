//
//  SearchVC.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/19/21.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView   = UIImageView()
    let userTextField   = GFTextField()
    let callToAction    = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var isUserTextfieldEntered: Bool {return !userTextField.text!.isEmpty }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToAction()
        createDismissKeyboardTapGesture()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowersToVC(){
        guard isUserTextfieldEntered else{
            presentGFAlertOnMainThread(title: "EMPTY USER NAME", message: "Please enter user name", button: "OK")
            return
            
        }
        
        let followersVC      = FollowersVC()
        followersVC.title    = userTextField.text
        followersVC.userName = userTextField.text
        
        navigationController?.pushViewController(followersVC, animated: true)
    }
    //MARK: - Configurations

    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(userTextField)
        userTextField.delegate = self

        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToAction() {
        view.addSubview(callToAction)
        callToAction.addTarget(self, action: #selector(pushFollowersToVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToAction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToAction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToAction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToAction.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
}
extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn (_ textfield: UITextField) -> Bool{
        pushFollowersToVC()
        return true
    }
}
