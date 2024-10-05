//
//  TabBarController.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import Foundation

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private let tabBarHeight: CGFloat = 92
    private var tabItems: [UIViewController] = []
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
        setTabBarUI()
        setTabBarHeight()
    }
}

private extension TabBarController {
    
    func setTabBarItems() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let mapVC = UINavigationController(rootViewController: MapViewController())
        let mypageVC = UINavigationController(rootViewController: MypageViewController())
        
        tabItems = [
            homeVC,
            mapVC,
            mypageVC
        ]
        
        TabBarItemType.allCases.forEach {
            let tabBarItem = $0.setTabBarItem()
            tabItems[$0.rawValue].tabBarItem = tabBarItem
            tabItems[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        let tabBarItemTitles: [String] = ["홈",
                                          "지도",
                                          "마이페이지"]
        
        for (index, tabTitle) in tabBarItemTitles.enumerated() {
            let tabBarItem = TabBarItemType(rawValue: index)?.setTabBarItem()
            tabItems[index].tabBarItem = tabBarItem
            tabItems[index].tabBarItem.tag = index
            tabItems[index].title = tabTitle
        }
        
        setViewControllers(tabItems, animated: false)
        selectedViewController = tabItems[0]
    }
    
    func setTabBarUI() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .mainBlue
        tabBar.unselectedItemTintColor = .gray300
        tabBar.layer.shadowColor = UIColor.gray300.cgColor
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 1
    }
    
    func getSafeAreaBottomHeight() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let safeAreaInsets = windowScene.windows.first?.safeAreaInsets
            let bottomSafeAreaHeight = safeAreaInsets?.bottom ?? 0
            return bottomSafeAreaHeight
        }
        return 0
    }
    
    func setTabBarHeight() {
        if let tabBar = self.tabBarController?.tabBar {
            let safeAreaBottomInset = self.view.safeAreaInsets.bottom
            let tabBarHeight = tabBar.bounds.height
            let newTabBarFrame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.y, width: tabBar.frame.width, height: tabBarHeight + safeAreaBottomInset)
            tabBar.frame = newTabBarFrame
        }
    }
}
