//
//  AccountSettingViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/09/14.
//

import UIKit

import SnapKit

class AccountSettingViewController: BaseViewController {
    let accountArr = ["로그아웃", "탈퇴하기"]
    let accountSettingView = AccountSettingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        accountSettingView.accountTableView.dataSource = self
        accountSettingView.accountTableView.delegate = self
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = "계정 설정"
    }

    override func setHierarchy() {
        self.view.addSubview(accountSettingView)
    }

    override func setConstraints() {
        accountSettingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension AccountSettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = accountSettingView.accountTableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        cell.setData(text: accountArr[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
