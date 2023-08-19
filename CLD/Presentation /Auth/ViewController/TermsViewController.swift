//
//  TermsViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/08/15.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift

final class TermsViewController: BaseViewController {
    
    private let badgeTitleLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = .boldSystemFont(ofSize: 20)
        UILabel.textColor = .CLDBlack
        UILabel.numberOfLines = 0
        UILabel.textAlignment = .left
        UILabel.text = "환영해요! 가입하려면\n약관에 동의가 필요해요."
        return UILabel
    }()
    private let allTermsCheckBox = TermsCheckBox()
    private lazy var termsTableView: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.rowHeight = 60
        t.showsVerticalScrollIndicator = false
        t.allowsMultipleSelection = true
        t.separatorStyle = .none
        t.register(TermsTableViewCell.self, forCellReuseIdentifier: "TermsTableViewCell")
        return t
    }()
    private var loginButton = CLDButton(title: "확인", isEnabled: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입"
        bind()
        bindAction()
    }
        
    private func bind() {
        Driver<[TermsType]>
            .just(TermsType.allCases)
            .drive(termsTableView.rx.items) { tableView, index, menu in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TermsTableViewCell", for: IndexPath(row: index, section: 0)) as? TermsTableViewCell else { return UITableViewCell() }
                cell.configCell(title: menu.description)
                cell.selectionStyle = .none
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        termsTableView.rx.itemSelected
            .subscribe { [weak self] (indexPath: IndexPath) in
                let row = TermsType.allCases[indexPath.row]
                switch row {
                case .termsOfUseRequired:
                    print(indexPath)
                case .personalInfoCollectionRequired:
                    print(indexPath)
                case .eventInfoConsent:
                    print(indexPath)
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func setHierarchy() {
        view.addSubviews(badgeTitleLabel, allTermsCheckBox, termsTableView, loginButton)
    }
    
    override func setConstraints() {
        badgeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(21)
        }
        
        allTermsCheckBox.snp.makeConstraints { make in
            make.top.equalTo(badgeTitleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
        
        termsTableView.snp.makeConstraints { make in
            make.top.equalTo(allTermsCheckBox.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(termsTableView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-15)
        }
        
    }
    
}
