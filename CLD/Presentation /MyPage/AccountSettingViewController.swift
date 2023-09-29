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
            let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "로그아웃", style: .destructive) { _ in
                self.postLogoutUser(device: DeviceUUID.getDeviceUUID(), refresh_token: UserDefaultHandler.refreshToken)
                self.resetUserDefaultValues()
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                sceneDelegate?.changeRootSplashView()
                return
            }
            let cancelAction = UIAlertAction(title: "취소", style: .default)
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴 시 계정과 관련된 모든 기록이 삭제되며, 복구할 수 없습니다. 1달 이내 다시 로그인 시 탈퇴가 자동 철회되며, 서비스를 계속 사용할 수 있습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "탈퇴하기", style: .destructive) { _ in
                self.deleteUser()
                self.resetUserDefaultValues()
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                sceneDelegate?.changeRootSplashView()
                return
            }
            let cancelAction = UIAlertAction(title: "취소", style: .default)
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
}

extension AccountSettingViewController {
    private func deleteUser() {
        NetworkService.shared.myPage.deleteUser() { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? BlankDataResponse else { return }
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
                guard let data = response as? BlankDataResponse else { return }
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
