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
                viewController = UINavigationController(rootViewController: CragSearchViewController())
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
            //지원할 크기 지정
            sheet.detents = [.medium(), .large()]
            //크기 변하는거 감지
            sheet.delegate = self
            //시트 상단에 그래버 표시 (기본 값은 false)
            sheet.prefersGrabberVisible = true
            //처음 크기 지정 (기본 값은 가장 작은 크기)
            sheet.selectedDetentIdentifier = .medium
            //뒤 배경 흐리게 제거 (기본 값은 모든 크기에서 배경 흐리게 됨)
            sheet.largestUndimmedDetentIdentifier = .medium
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
