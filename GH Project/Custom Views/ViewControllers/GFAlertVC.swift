//
//  GFAlertVC.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/21/21.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let containerView   = GFContainerView()
    let titleLabel      = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let bodyMessage     = GFBodyLabel(textAlignment: .center)
    let actionButton    = GFButton(backgroundColor: .systemRed, title: "Ok")
    let padding:CGFloat = 20
    
    var alertTitle: String?
    var message: String?
    var buttonLabel: String?
    
    
    init (title: String, message: String, buttonLabel: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle  = title
        self.message     = message
        self.buttonLabel = buttonLabel
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        containerView.addSubviews(titleLabel, bodyMessage, actionButton)
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyMessage()
    }
    
    
    func configureContainerView(){
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    func configureTitleLabel(){
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureBodyMessage(){
        bodyMessage.text          = message ?? "Unable to complete request"
        bodyMessage.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            bodyMessage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyMessage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            bodyMessage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            bodyMessage.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    func configureActionButton(){
        actionButton.setTitle(buttonLabel ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
