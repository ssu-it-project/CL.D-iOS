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
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = "프로필 설정"

        profileSettingView.delegate = self
        profileSettingView.imagePicker.delegate = self
        self.photo.delegate = self
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
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
