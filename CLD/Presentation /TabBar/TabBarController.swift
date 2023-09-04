//
//  TabBarController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/19.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let tabBarItems = TabBarItem.allCases
    
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(setViewController(tabBarItems), animated: true)
        
        setUpTabBar()
        self.delegate = self
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
                viewController = UINavigationController(rootViewController: ClimbingGymSearchViewController())
            case .record:
                viewController = UINavigationController(rootViewController: HomeViewController())
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

extension TabBarController: UISheetPresentationControllerDelegate {
    func presentModalBtnTap() {
        let vc = RecordViewController()
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
            sheet.selectedDetentIdentifier = .medium
        }
        present(vc, animated: true, completion: nil)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let recordIndex: Int = viewController.tabBarController?.selectedIndex else { return }
        if( recordIndex == 2 ){
            presentModalBtnTap()
        }
    }
}
