//
//  ProfileSettingViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/09/14.
//

import UIKit

import SnapKit
import Photos

class ProfileSettingViewController: BaseViewController {
    let profileSettingView = ProfileSettingView()
    let photo = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        profileSettingView.delegatePush = self
        profileSettingView.delegateUpdate = self
        profileSettingView.imagePicker.delegate = self
        self.photo.delegate = self
        getUser()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        if #available(iOS 16.0, *) {
            self.navigationItem.leftBarButtonItem?.isHidden = false
        }
        navigationItem.title = "프로필 설정"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

    override func setHierarchy() {
        self.view.addSubview(profileSettingView)
    }

    override func setConstraints() {
        profileSettingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ProfileSettingViewController: PushProfileViewDelegate {
    func editProfileButtonTapped() {
        let photoAurhorizationStatus = PHPhotoLibrary.authorizationStatus()

        switch photoAurhorizationStatus {
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized:
                    print("사용자가 허용함")
                    self.openPhoto()
                case .denied:
                    print("사용자가 불허함")
                default: break
                }
            })
        case .restricted:
            print("접근 제한")
        case .denied:
            print("접근 불허")
            let alert = UIAlertController(title: "권한 없음", message: """
                                          사진 접근 권한이 없습니다.
                                          설정 > 개인 정보 보호 > 사진에서
                                          권한을 추가하세요.
                                          """, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "설정", style: .default) { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                return
            }
            let cancelAction = UIAlertAction(title: "취소", style: .default) { _ in
                return
            }
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            present(alert, animated: true)
        case .authorized:
            print("접근 허가됨")
            self.openPhoto()
        case .limited:
            print("limited")
        @unknown default:
            print("unknown default")
        }
    }

    func openPhoto(){
        DispatchQueue.main.async {
            self.photo.sourceType = .photoLibrary
            self.photo.allowsEditing = false
            self.present(self.photo, animated: false, completion: nil)
        }
    }
}

extension ProfileSettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage]{
            profileSettingView.setProfileImage(image: img as! UIImage)
            putUserImage(image: img as! UIImage) { _ in
                print("=== putUserImage 성공")
            }
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProfileSettingViewController: UpdateProfileDelegate {
    func saveProfileButtonTapped() {
        profileSettingView.closeKeyBoard()
        let profileInfo = profileSettingView.getProfileInfo()
        let birthday: String = profileInfo["birthday"] as! String
        let gender: Int = profileInfo["gender"] as! Int
        let name: String = profileInfo["name"] as! String
        let nickname: String = profileInfo["nickname"] as! String
        let height: Int = profileInfo["height"] as! Int
        let armReach: Int = profileInfo["armReach"] as! Int
        putUserInfo(birthday: birthday, gender: gender, name: name, nickname: nickname, height: height, reach: armReach) { _ in
            print("=== putUserInfo 성공")
        }
    }
}

extension ProfileSettingViewController {
    private func getUser() {
        NetworkService.shared.myPage.getUser() { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? UserDTO else { return }
                self?.profileSettingView.setProfileInfo(birthday: data.profile.birthday, gender: data.profile.gender, name: data.profile.name, imageUrl: data.profile.image, nickname: data.profile.nickname, height: data.profile.physical.height, reach: data.profile.physical.reach)

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

    private func putUserImage(image: UIImage, completion: @escaping(BlankDataResponse) -> Void) {
        NetworkService.shared.myPage.putUserImage(image: image) { [weak self] result in
            switch result {
            case .success(let response):
                guard response is BlankDataResponse else { return }
                let alert = self?.createOKAlert("프로필 사진", "프로필 사진이 수정되었습니다.")
                self?.present(alert!, animated: true)
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

    private func putUserInfo(birthday: String, gender: Int, name: String, nickname: String, height: Int, reach: Int, completion: @escaping(BlankDataResponse) -> Void) {
        NetworkService.shared.myPage.putUserInfo(birthday: birthday, gender: gender, name: name, nickname: nickname, height: height, reach: reach) { [weak self] result in
            switch result {
            case .success(let response):
                guard response is BlankDataResponse else { return }
                let alert = self?.createOKAlert("프로필 정보", "프로필 정보가 수정되었습니다.")
                self?.present(alert!, animated: true)
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
