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

    private func resetUserDefaultValues() {
        UserDefaultHandler.accessToken = ""
        UserDefaultHandler.refreshToken = ""
        UserDefaultHandler.loginStatus = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        accountSettingView.accountTableView.dataSource = self
        accountSettingView.accountTableView.delegate = self
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        if #available(iOS 16.0, *) {
            self.navigationItem.leftBarButtonItem?.isHidden = false
        }
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
        if (index == 0){
            let alert = createBasicAlert("로그아웃", TextLiteral.logoutMessage, "로그아웃") { [weak self] in
                guard let self = self else { return }
                self.postLogoutUser(device: DeviceUUID.getDeviceUUID(), refresh_token: UserDefaultHandler.refreshToken)
                self.resetUserDefaultValues()
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                sceneDelegate?.changeRootSplashView()
            }
            present(alert, animated: true)
        } else {
            let alert = createBasicAlert("탈퇴하기", TextLiteral.withdrawMessage, "탈퇴하기") { [weak self] in
                guard let self = self else { return }
                self.deleteUser()
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                sceneDelegate?.changeRootSplashView()
            }
            present(alert, animated: true)
        }
    }
}

extension AccountSettingViewController {
    private func deleteUser() {
        NetworkService.shared.myPage.deleteUser() { [weak self] result in
            switch result {
            case .success(let response):
                guard response is BlankDataResponse else { return }
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data.message ?? "requestErr")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }

    private func postLogoutUser(device: String, refresh_token: String) {
        NetworkService.shared.myPage.postLogoutUser(device: device, refresh_token: refresh_token) { [weak self] result in
            switch result {
            case .success(let response):
                guard response is BlankDataResponse else { return }
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data.message ?? "requestErr")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
