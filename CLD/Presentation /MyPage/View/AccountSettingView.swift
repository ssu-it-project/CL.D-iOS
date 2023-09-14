//
//  AccountSettingView.swift
//  CLD
//
//  Created by 이조은 on 2023/09/14.
//

import UIKit

import SnapKit

final class AccountSettingView: UIView {
    lazy var accountTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.rowHeight = 42
        tableView.separatorInset.left = 10
        tableView.separatorInset.right = 10

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setHierarchy()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setHierarchy() {
        addSubview(accountTableView)
    }

    func setConstraints() {
        accountTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

