//
//  RootHandler.swift
//  CLD
//
//  Created by 김규철 on 2023/08/27.
//

import UIKit

final class RootHandler {
    static let shard = RootHandler()
    
    enum Destination {
        case Main
        case Terms
    }
    
    private init() {}
    
    func update(_ destination: Destination) {
        guard let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        switch destination {
        case .Main:
            let mainViewController = TabBarController()
            delegate.window?.rootViewController = mainViewController
            delegate.window?.makeKeyAndVisible()
        case .Terms:
            let termsViewController = TermsViewController(viewModel: SignUpViewModel(useCase: DefaultSignUpUseCase(repository: DefaultSignUpRepository())))
            let nav = UINavigationController(rootViewController: termsViewController)
            delegate.window?.rootViewController = nav
            delegate.window?.makeKeyAndVisible()
        }
    }
}
