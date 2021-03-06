//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 21/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String)
}


class UserInfoVC: UIViewController {
    
    let scrollView              = UIScrollView()
    let contentForScrollView    = UIView()
    
    let headerView              = UIView()
    let itemViewOne             = UIView()
    let itemViewTwo             = UIView()
    let dateLabel               = MLBodyLabel(textAlignment: .center)
    
    var itemViews: [UIView]     = []
    
    var username: String!
    weak var delegate: FollowerListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
        
        
    }
    
    
    func configureViewController() {
        view.backgroundColor                = .systemBackground
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = doneButton
        
    }
    
    
    func configureScrollView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentForScrollView)
        
        scrollView.takeAllAvailableSpace(in: view)
        contentForScrollView.takeAllAvailableSpace(in: scrollView)
        
        NSLayoutConstraint.activate([
            contentForScrollView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentForScrollView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElement(with: user) }
            case .failure(let error):
                self.presentMLAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "🙁")
                break
            }
            
        }
    }
    
    
    func configureUIElement(with user: User) {
        self.add(
            childVC: MLUserInfoHeaderVC(user: user),
            to: self.headerView
        )
        self.add(
            childVC: MLRepoItemVC(user: user, delegate: self),
            to: self.itemViewOne
        )
        self.add(
            childVC: MLFollowerItemVC(user: user, delegate: self),
            to: self.itemViewTwo
        )
        self.setDateLabel(with: user.createdAt)
        
    }
    
    
    func layoutUI() {
        let padding: CGFloat        = 20
        let itemHeight: CGFloat     = 140
        
        itemViews.append(contentsOf: [headerView, itemViewOne, itemViewTwo, dateLabel])
        
        itemViews.forEach {
            contentForScrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: contentForScrollView.leadingAnchor, constant: padding),
                $0.trailingAnchor.constraint(equalTo: contentForScrollView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentForScrollView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    func setDateLabel(with date: Date) {
        let formatter           = DateFormatter()
        formatter.locale        = .current
        formatter.dateFormat    = "MMM yyyy"
        
        dateLabel.text          = "GitHub Since \(formatter.string(from: date))"
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}


extension UserInfoVC: MLRepoItemVCDelegate {
    func didTapGitHubProfile(for user: User) {
        // show safari view controller
        
        guard let url = URL(string: user.htmlUrl) else {
            presentMLAlertOnMainThread(title: "Invalid URL", message: "The URL attached to this user is invalid", buttonTitle: "Oh no!")
            return
        }
        
        presentSafariVC(with: url)
    }
}


extension UserInfoVC: MLFollowerItemVCDelegate {
    func didTapGetFollowers(for user: User) {
        // dismiss vc
        // tell follower list screen the new use
        
        guard user.followers != 0 else {
            presentMLAlertOnMainThread(title: "No followers", message: "This user has no followers. Go follow them 😇", buttonTitle: "On it!")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
    
}
