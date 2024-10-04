//
//  SplashViewController.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//


import UIKit

import SnapKit

final class SplashViewController: UIViewController {
    
    private let splashView = SplashView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            self.checkToken()
        }
    }
    
}

extension SplashViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func checkToken() {
        if UserManager.shared.hasAccessToken {
//            let nav = TabBarController()
//            self.navigationController?.pushViewController(nav, animated: true)
        } else {
            let nav = LoginViewController()
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
}
