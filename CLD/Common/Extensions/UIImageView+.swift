//
//  UIImageView+.swift
//  CLD
//
//  Created by 김규철 on 2023/09/15.
//

import UIKit

import Kingfisher

extension UIImageView {
    func setImage(urlString: String) {
        ImageCache.default.retrieveImage(forKey: urlString, options: nil) { result in
            switch result {
            case .success(let value):
                if let image = value.image {
                    self.image = image
                } else {
                    guard !urlString.isEmpty, let url = URL(string: urlString) else {
                        self.image = ImageLiteral.DefaultGymImage
                        return
                    }
    
                    let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
                    self.kf.indicatorType = .activity
                    self.kf.setImage(with: resource,
                                     placeholder: nil,
                                     options: [.transition(.fade(1.0))],
                                     completionHandler: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
