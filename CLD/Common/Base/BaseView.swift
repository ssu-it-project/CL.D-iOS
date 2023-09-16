//
//  BaseView.swift
//  CLD
//
//  Created by 김규철 on 2023/09/16.
//

import UIKit

protocol BaseViewProtocol: AnyObject, BaseViewItemProtocol {
    
    /// view binding 설정
    func bind()
}


class BaseView: UIView, BaseViewProtocol {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstraints()
        setViewProperty()
        bind()
    }
    
    @available(*, unavailable, message: "remove required init")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {}
    
    func setConstraints() {}
    
    func bind() {}
    
    func setViewProperty() {
        self.backgroundColor = .white
    }
}
