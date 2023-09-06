//
//  BaseViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/19.
//

import UIKit
import RxSwift

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
    
    /// view binding 설정
    func Bind()
}

 class BaseViewController: UIViewController, BaseViewControllerProtocol {
     var disposeBag: DisposeBag = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

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
    }

     func setViewProperty() {
         self.view.backgroundColor = .white
     }
     func setDelegate() { }
     func setHierarchy() { }
     func setConstraints() { }
     func Bind() { }
}
