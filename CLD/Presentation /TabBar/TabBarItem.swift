//
//  TabBarItem.swift
//  CLD
//
//  Created by 김규철 on 2023/07/19.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case home
    case cragSearch
    case record
    case community
    case myPage
    
    var image: UIImage {
        switch self {
        case .home:
            return ImageLiteral.homeIcon
        case .cragSearch:
            return ImageLiteral.searchIcon
        case .record:
            return ImageLiteral.recordIcon
        case .community:
            return ImageLiteral.communityIcon
        case .myPage:
            return ImageLiteral.myPageIcon
        }
    }
    
    /// fix: selectedImage 나오면 이미지 교체하기
    var selectedImage: UIImage {
        switch self {
        case .home:
            return ImageLiteral.homeIcon
        case .cragSearch:
            return ImageLiteral.searchIcon
        case .record:
            return ImageLiteral.recordIcon
        case .community:
            return ImageLiteral.communityIcon
        case .myPage:
            return ImageLiteral.myPageIcon
        }
    }
}

extension TabBarItem {
    func toTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: nil,
            image: image,
            selectedImage: selectedImage
        )
    }
}
