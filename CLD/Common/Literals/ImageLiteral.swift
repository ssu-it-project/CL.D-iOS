//
//  ImageLiteral.swift
//  CLD
//
//  Created by 김규철 on 2023/07/19.
//

import UIKit

enum ImageLiteral {
    
    // MARK: - tab bar icon
    static var homeIcon: UIImage { .load(named: "homeIcon") }
    static var searchIcon: UIImage { .load(named: "searchIcon") }
    static var recordIcon: UIImage { .load(named: "recordIcon") }
    static var communityIcon: UIImage { .load(named: "communityIcon") }
    static var myPageIcon: UIImage { .load(named: "myPageIcon") }
    
    //MARK: - logo icon
    static var cldLogo: UIImage { .load(named: "cldLogo") }
    static var kakaoLogo: UIImage { .load(named: "kakaoLogo") }
    static var appleLogo: UIImage { .load(named: "appleLogo") }
    static var instaLogo: UIImage { .load(named: "instaLogo") }
    
    //MARK: - Home
    static var commentIcon: UIImage { .load(named: "commentIcon") }
    static var shareIcon: UIImage { .load(named: "shareIcon") }
    static var likeIcon: UIImage { .load(named: "likeIcon") }
    static var videoCellMenuIcon: UIImage { .load(named: "videoCellMenuIcon") }
    static var badgeInfoIcon: UIImage { .load(named: "badgeInfoIcon") }
    
    //MARK: - Record
    static var dotDivider: UIImage { .load(named: "DotDivider") }
    static var placeIcon: UIImage { .load(named: "placeIcon") }
    static var STIcon: UIImage { .load(named: "STIcon") }
    static var VIcon: UIImage { .load(named: "VIcon") }
    static var backButton: UIImage { .load(named: "backButton") }
    static var addIcon: UIImage { .load(named: "addIcon") }
    
    //MARK: - test image
    static var videoThumbnail: UIImage { .load(named: "videoThumbnail") }
    static var testthumBnailImage: UIImage { .load(named: "thumbnailImage") }
    
    //MARK: - System image
    static var checkIcon: UIImage { .load(systemName: "checkmark")}
    static var thumbnailImage: UIImage { .load(named: "thumbnailImage")}
}

extension UIImage {
    
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = imageName
        return image
    }
    
    static func load(systemName: String) -> UIImage {
        guard let image = UIImage(systemName: systemName, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = systemName
        return image
    }
}
