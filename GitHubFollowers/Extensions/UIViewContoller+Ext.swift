//
//  File.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 15/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentMLAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = MLAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            
            self.present(alertVC, animated: true)
        }
        
    }
}
