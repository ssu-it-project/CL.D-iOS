//
//  BaseViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/19.
//

import UIKit
import RxSwift
import RxCocoa

protocol BaseViewItemProtocol: AnyObject {
    /// view property 설정 - ex ) view.backgroundColor = .white
    func setViewProperty()
    
    /// 뷰 계층 구조 설정 - ex ) view.addSubview()
    func setHierarchy()
    
    /// layout 설정 - ex ) snapkit
    func setConstraints()
}

protocol BaseViewControllerProtocol: AnyObject, BaseViewItemProtocol {
    /// delegate 설정
    func setDelegate()
    
    /// Navigation 설정
    func setupNavigationBar()
    
    /// view binding 설정
    func Bind()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    var disposeBag: DisposeBag = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    let customBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .CLDBlack

        return button
    }()

    @available(*, unavailable, message: "remove required init")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        Bind()
        setViewProperty()
        setDelegate()
        setHierarchy()
        setConstraints()
        setupNavigationBar()
    }

    func setViewProperty() {
        self.view.backgroundColor = .white
    }
    func setDelegate() { }
    func setHierarchy() { }
    func setConstraints() { }
    func Bind() { }

    func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }

    func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()

        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: RobotoFont.Regular.of(size: 15)]

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customBackButton)
        if #available(iOS 16.0, *) {
            self.navigationItem.leftBarButtonItem?.isHidden = true
        }

        customBackButton.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
    }
}
