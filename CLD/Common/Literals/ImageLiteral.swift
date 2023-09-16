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
    static var kakaoLogo: UIImage { .load(named: "kakao_login") }
    static var appleLogo: UIImage { .load(named: "apple_login") }
    static var instaLogo: UIImage { .load(named: "facebook_login") }
    
    //MARK: - Home
    static var commentIcon: UIImage { .load(named: "commentIcon") }
    static var shareIcon: UIImage { .load(named: "shareIcon") }
    static var likeIcon: UIImage { .load(named: "likeIcon") }
    static var videoCellMenuIcon: UIImage { .load(named: "videoCellMenuIcon") }
    static var badgeInfoIcon: UIImage { .load(named: "badgeInfoIcon") }
    
    //MARK: - Gym
    static var DefaultGymImage: UIImage { .load(named: "DefaultGym") }
    static var DefaultDetailGymVideoImage: UIImage { .load(named: "DefaultDetailGymVideo").resize(newWidth: 250) }
    static var ParkingIcon: UIImage { .load(named: "Parking") }
    
    //MARK: - Record
    static var dotDivider: UIImage { .load(named: "DotDivider") }
    static var placeIcon: UIImage { .load(named: "placeIcon") }
    static var STIcon: UIImage { .load(named: "STIcon") }
    static var VIcon: UIImage { .load(named: "VIcon") }
    static var backButton: UIImage { .load(named: "backButton") }
    static var addIcon: UIImage { .load(named: "addIcon") }
    
    //MARK: - System image
    static var checkIcon: UIImage { .load(systemName: "checkmark")}
    static var bookMarkIcon: UIImage { .load(systemName: "bookmark") }
    static var fillBookMarkIcon: UIImage { .load(systemName: "bookmark.fill") }
    static var thumbnailImage: UIImage { .load(named: "thumbnailImage")}

    //MARK: - MyPage
    static var settingIcon: UIImage { .load(named: "settingIcon")}
    static var videoIcon: UIImage { .load(named: "videoIcon")}
    static var editProfileImage: UIImage { .load(named: "editProfileImage")}

    //MARK: - test image
    static var videoThumbnail: UIImage { .load(named: "videoThumbnail") }
    static var testthumBnailImage: UIImage { .load(named: "thumbnailImage") }
    static var testProfileImage: UIImage { .load(named: "seolgi") }
    static var testBadgeImage: UIImage { .load(named: "testBadgeImage") }
    static var holderBlue: UIImage { .load(named: "holderBlue") }
    static var holderOrange: UIImage { .load(named: "holderOrange") }
    static var holderPurple: UIImage { .load(named: "holderPurple") }
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
