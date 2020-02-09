//
//  File.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 15/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentMLAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = MLAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            
            self.present(alertVC, animated: true)
        }
        
    }
    
    func showEmptyStateView(withMessage message: String, in view: UIView) {
        let emptyStateView = MLEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        
        if view.subviews.contains(emptyStateView) {
            view.bringSubviewToFront(emptyStateView)
        } else {
            view.addSubview(emptyStateView)
        }
        
    }
    
    func removeEmptyStateView(in view: UIView) {
        view.subviews.forEach { subView in
            if subView is MLEmptyStateView {
                subView.removeFromSuperview()
            }
        }
    }
    
    func presentSafariVC(with url: URL) {
        
        let safariVC                        = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor  = .systemGreen
        
        // safariVC.preferredBarTintColor      = .systemPurple
        
        present(safariVC, animated: true)
        
    }
}
