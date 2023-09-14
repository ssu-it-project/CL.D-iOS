//
//  SettingViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/09/14.
//

import UIKit

import SnapKit

class SettingViewController: BaseViewController {
    let infoArr = ["프로필 설정", "계정 설정", "이용약관 및 운영정책", "앱 버전"]
    let settingView = SettingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        settingView.settingTableView.dataSource = self
        settingView.settingTableView.delegate = self
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = "설정"
    }

    override func setHierarchy() {
        self.view.addSubview(settingView)
    }

    override func setConstraints() {
        settingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = settingView.settingTableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        cell.setData(text: infoArr[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: IndexPath = indexPath
        //let nextViewController = ImageZoomViewController()
        //self.navigationController?.pushViewController(nextViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
