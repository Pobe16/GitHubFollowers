//
//  ViewController.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 05/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView       = UIImageView()
    let usernameTextField   = MLTextField()
    let callToActionButton  = MLButton(withColor: .systemGreen, withTitle: "Get Followers")
    
//    you don't need a return if it's just one line
    var isUsernameEntered: Bool {
        !usernameTextField.text!.isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        print(view.bounds.size)
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
        
    }
    
    // Always hide the navigation bar
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.usernameTextField.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentMLAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😉", buttonTitle: "OK")
            return
            
        }
        let followerListVC          = FollowerListVC()
        followerListVC.username     = usernameTextField.text
        followerListVC.title        = usernameTextField.text
        
        navigationController?.pushViewController(followerListVC, animated: true)
    }

    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "gh-logo")!
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func configureCallToActionButton () {
        view.addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        pushFollowerListVC()
        return true
    }
}

