//
//  ProfileSettingView.swift
//  CLD
//
//  Created by 이조은 on 2023/09/14.
//

import UIKit

import SnapKit
import RxSwift
import RxGesture
import RxCocoa

protocol PushProfileViewDelegate: AnyObject {
    func editProfileButtonTapped()
}

protocol UpdateProfileDelegate: AnyObject {
    func saveProfileButtonTapped()
}

final class ProfileSettingView: UIView {
    private lazy var birthday = ""
    private lazy var gender = 0
    private lazy var name = ""
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.profileDefault
        imageView.tintColor = .CLDGray
        imageView.layer.cornerRadius = 105/2
        imageView.clipsToBounds = true

        return imageView
    }()
    let imagePicker = UIImagePickerController()
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.editProfileImage, for: .normal)

        return button
    }()

    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = RobotoFont.Bold.of(size: 16)
        label.text = "닉네임"
        label.textColor = .black
        label.textAlignment = .left

        return label
    }()
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요."
        textField.font = RobotoFont.Regular.of(size: 14)
        textField.textColor = .CLDBlack
        textField.backgroundColor = .CLDLightGray

        return textField
    }()

    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.font = RobotoFont.Bold.of(size: 16)
        label.text = "키"
        label.textColor = .black
        label.textAlignment = .left

        return label
    }()
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요."
        textField.font = RobotoFont.Regular.of(size: 14)
        textField.textColor = .CLDBlack
        textField.backgroundColor = .CLDLightGray

        return textField
    }()
    private lazy var heightcmLabel: UILabel = {
        let label = UILabel()
        label.font = RobotoFont.Bold.of(size: 14)
        label.text = "cm"
        label.textColor = .CLDDarkGray
        label.textAlignment = .right

        return label
    }()

    private lazy var armReachLabel: UILabel = {
        let label = UILabel()
        label.font = RobotoFont.Bold.of(size: 16)
        label.text = "암리치"
        label.textColor = .black
        label.textAlignment = .left

        return label
    }()
    private let armReachTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "암리치를 입력해주세요."
        textField.font = RobotoFont.Regular.of(size: 14)
        textField.textColor = .CLDBlack
        textField.backgroundColor = .CLDLightGray

        return textField
    }()
    private lazy var armReachcmLabel: UILabel = {
        let label = UILabel()
        label.font = RobotoFont.Bold.of(size: 14)
        label.text = "cm"
        label.textColor = .CLDDarkGray
        label.textAlignment = .right

        return label
    }()

    private let underLineNickname: CALayer = {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 30, width: 330, height: 1)
        border.backgroundColor = UIColor.CLDGold.cgColor
        return border
    }()
    private let underLineHeight: CALayer = {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 30, width: 330, height: 1)
        border.backgroundColor = UIColor.CLDGold.cgColor
        return border
    }()
    private let underLineArmReach: CALayer = {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 30, width: 330, height: 1)
        border.backgroundColor = UIColor.CLDGold.cgColor
        return border
    }()

    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = RobotoFont.Medium.of(size: 14)
        button.backgroundColor = .CLDGold
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 4

        return button
    }()

    weak var delegatePush: PushProfileViewDelegate?
    weak var delegateUpdate: UpdateProfileDelegate?
    private var bag = DisposeBag()

    func setProfileInfo(birthday: String, gender: Int, name: String, imageUrl: String, nickname: String, height: Int, reach: Int) {
        self.birthday = birthday
        self.gender = gender
        self.name = name
        self.profileImageView.setImage(urlString: imageUrl, defaultImage: ImageLiteral.profileDefault)
        self.nicknameTextField.text = nickname
        self.heightTextField.text = String(height)
        self.armReachTextField.text = String(reach)
    }

    func setProfileImage(image: UIImage) {
        self.profileImageView.image = image
    }

    func getProfileInfo() -> Dictionary<String, Any> {
        let nickname: String = String(nicknameTextField.text ?? "")
        let height: Int = Int(String(heightTextField.text ?? "")) ?? 0
        let armReach: Int = Int(String(armReachTextField.text ?? "")) ?? 0
        return ["birthday": birthday, "gender": gender, "name":name, "nickname": nickname, "height": height, "armReach": armReach]
    }

    func closeKeyBoard() {
        nicknameTextField.resignFirstResponder()
        heightTextField.resignFirstResponder()
        armReachTextField.resignFirstResponder()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        nicknameTextField.addLeftPadding()
        heightTextField.addLeftPadding()
        armReachTextField.addLeftPadding()
        nicknameTextField.layer.addSublayer((underLineNickname))
        heightTextField.layer.addSublayer((underLineHeight))
        armReachTextField.layer.addSublayer((underLineArmReach))

        setHierarchy()
        setConstraints()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setHierarchy() {
        addSubviews(profileImageView, editProfileButton, nicknameLabel, nicknameTextField, heightLabel, heightTextField, armReachLabel, armReachTextField, saveButton)
        heightTextField.addSubview(heightcmLabel)
        armReachTextField.addSubview(armReachcmLabel)
    }

    func setConstraints() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(108)
            $0.top.equalToSuperview().inset(105)
            $0.centerX.equalToSuperview()
        }
        editProfileButton.snp.makeConstraints {
            $0.size.equalTo(28)
            $0.bottom.equalTo(profileImageView.snp.bottom)
            $0.leading.equalTo(profileImageView.snp.leading).offset(82)
        }
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(21)
            $0.leading.equalToSuperview().inset(32)
        }
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(330)
            $0.height.equalTo(32)
        }
        heightLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(21)
            $0.leading.equalToSuperview().inset(32)
        }
        heightTextField.snp.makeConstraints {
            $0.top.equalTo(heightLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(330)
            $0.height.equalTo(32)
        }
        heightcmLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(9)
            $0.centerY.equalToSuperview()
        }
        armReachLabel.snp.makeConstraints {
            $0.top.equalTo(heightTextField.snp.bottom).offset(21)
            $0.leading.equalToSuperview().inset(32)
        }
        armReachTextField.snp.makeConstraints {
            $0.top.equalTo(armReachLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(330)
            $0.height.equalTo(32)
        }
        armReachcmLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(9)
            $0.centerY.equalToSuperview()
        }
        saveButton.snp.makeConstraints {
            $0.top.equalTo(armReachTextField.snp.bottom).offset(23)
            $0.trailing.equalToSuperview().inset(33)
            $0.width.equalTo(45)
            $0.height.equalTo(25)
        }
    }

    private func bind() {
        editProfileButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, event in
                owner.delegatePush?.editProfileButtonTapped()
            })
            .disposed(by: bag)
        saveButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, event in
                owner.delegateUpdate?.saveProfileButtonTapped()
            })
            .disposed(by: bag)
    }
}
