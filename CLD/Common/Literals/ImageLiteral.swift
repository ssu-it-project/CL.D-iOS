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
