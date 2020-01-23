//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 21/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView              = UIView()
    let itemViewOne             = UIView()
    let itemViewTwo             = UIView()
    
    var itemViews: [UIView]     = []
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getUserInfo()
        
        
    }
    
    
    func configureViewController() {
        view.backgroundColor                = .systemBackground
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = doneButton
        
    }
    
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: MLUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentMLAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "🙁")
                break
            }
            
        }
    }
    
    
    func layoutUI() {
        let padding: CGFloat        = 20
        let itemHeight: CGFloat     = 180
        
        itemViews.append(contentsOf: [headerView, itemViewOne, itemViewTwo])
        
        itemViews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                $0.heightAnchor.constraint(equalToConstant: itemHeight)
            ])
        }
        
        itemViewOne.backgroundColor = .systemPink
        itemViewTwo.backgroundColor = .systemBlue
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding)
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    


}
