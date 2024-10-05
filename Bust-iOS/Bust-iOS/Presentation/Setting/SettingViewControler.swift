//
//  SettingViewControler.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit


final class SettingViewController: UIViewController {
    
    private let serviceMenu = SettingMenu.serviceMenu()
    private let accountMenu = SettingMenu.accountMenu()
    
    // MARK: - UI Components
    
    private let settingView = SettingView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
    }
}

// MARK: - Extensions

extension SettingViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func setDelegate() {
        settingView.settingServiceTableView.dataSource = self
        settingView.settingAccountTableView.dataSource = self
        settingView.backButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func changeRootToSplashVC() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let spalshVC = SplashViewController()
                let navigationController = UINavigationController(rootViewController: spalshVC)
                window.rootViewController = navigationController
            }
        }
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingTableViewCell.dequeueReusableCell(tableView: settingView.settingServiceTableView, indexPath: indexPath)
        if indexPath.section == 0 {
            cell.configureSettingCell(menu: serviceMenu[indexPath.row])
        } else {
            cell.configureSettingCell(menu: accountMenu[indexPath.row])
        }
        return cell
    }
}
