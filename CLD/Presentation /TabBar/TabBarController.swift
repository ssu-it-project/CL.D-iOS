//
//  TabBarController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/19.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let tabBarItems = TabBarItem.allCases
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(setViewController(tabBarItems), animated: true)
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .CLDGray
        self.tabBar.backgroundColor = .white
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    
    private func setViewController(_ tabBarItems: [TabBarItem]) -> [UIViewController] {
        tabBarItems.map { tabBarItem in
            let viewController: UIViewController
            
            switch tabBarItem {
            case .home:
                viewController = UINavigationController(rootViewController: HomeViewController())
            case .cragSearch:
                viewController = UINavigationController(rootViewController: CragSearchViewController())
            case .record:
                viewController = UINavigationController(rootViewController: RecordViewController())
            case .community:
                viewController = UINavigationController(rootViewController: CommunityViewController())
            case .myPage:
                viewController = UINavigationController(rootViewController: MyPageViewController())
            }
            
            viewController.tabBarItem = tabBarItem.toTabBarItem()
            return viewController
        }
    }
}
