//
//  TermsCheckListView.swift
//  CLD
//
//  Created by 김규철 on 2023/08/21.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import RxGesture

protocol PushTermsViewDelegate: AnyObject {
    func detailButtonTapped(index: Int)
}

final class TermsCheckListView: UIView {
    
     let termsCheckButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.buttonSize = .large
        configuration.title = "[필수] 클디 이용약관 동의"
         configuration.image = ImageLiteral.checkIcon 
        configuration.baseForegroundColor = .CLDDarkGray
        configuration.imagePadding = 7
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        configuration.imagePlacement = .leading
        let button = UIButton()
        button.configuration = configuration
        button.titleLabel?.font = .systemFont(ofSize: 20)
        return button
    }()
    private let termsDetailButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.buttonSize = .large
        configuration.baseForegroundColor = .CLDDarkGray
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 16)
        let button = UIButton()
        button.configuration = configuration
        return button
    }()
    
    weak var delegate: PushTermsViewDelegate?
    private var bag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        buttonConfigurationUpdateHandler()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(tag: Int, title: String) {
        self.init()
        self.termsDetailButton.tag = tag
        self.termsCheckButton.configuration?.title = title
    }
    
    private func bind() {
        termsCheckButton.rx.tap
            .withUnretained(self)
            .map { !$0.0.termsCheckButton.isSelected }
            .bind(to: termsCheckButton.rx.isSelected)
            .disposed(by: bag)
        
        termsDetailButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, event in
                owner.delegate?.detailButtonTapped(index: owner.termsDetailButton.tag)
            })
            .disposed(by: bag)
            
    }
        
    private func buttonConfigurationUpdateHandler() {
        termsCheckButton.configurationUpdateHandler = { [weak self] btn in
            switch btn.state {
            case .selected:
                btn.configuration?.baseForegroundColor = .CLDBlack
                btn.configuration?.background.backgroundColor = .white
                self?.termsDetailButton.configuration?.baseForegroundColor = .CLDBlack
            case .normal:
                btn.configuration?.baseForegroundColor = .CLDDarkGray
                self?.termsDetailButton.configuration?.baseForegroundColor = .CLDDarkGray
            default:
                break
            }
        }
    }
    
    private func layout() {
        let stackView = createTotalStackView()
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func createTotalStackView() -> UIStackView {
        let subviews = [termsCheckButton, UIView(), termsDetailButton]
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }
}

extension Reactive where Base: UIButton {
    var isSelected: ControlProperty<Bool> {
        return base.rx.controlProperty(
            editingEvents: [.touchUpInside],
            getter: { $0.isSelected },
            setter: { $0.isSelected = $1 })
    }
}
