//
//  SettingView.swift
//  CLD
//
//  Created by 이조은 on 2023/09/14.
//

import UIKit

import SnapKit

final class SettingView: UIView {
    lazy var settingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.backgroundColor = .clear
        // tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = 42
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
        addSubview(settingTableView)
    }

    func setConstraints() {
        settingTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
