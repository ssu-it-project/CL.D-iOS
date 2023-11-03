//
//  PostRecordView.swift
//  CLD
//
//  Created by 이조은 on 2023/08/21.
//

import UIKit

import SnapKit

final class PostRecordView: UIView {
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.backButton, for: .normal)
        button.tintColor = .CLDBlack
        button.addTarget(self, action: #selector(PostRecordViewController.backPage), for: .touchUpInside)
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새 게시물"
        label.textColor = .black
        label.font = RobotoFont.Regular.of(size: 15)
        return label
    }()
    private let thumbnailView: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.thumbnailImage
        view.contentMode = .scaleAspectFill
        view.backgroundColor = nil
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private let playIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "play.fill")
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        view.backgroundColor = nil
        return view
    }()
    private let labelBackground: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 27, height: 12)
        view.layer.backgroundColor = UIColor.CLDMediumGray.cgColor
        view.layer.opacity = 0.9
        view.layer.cornerRadius = 2
        return view
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "2:10"
        label.textColor = .white
        label.font = RobotoFont.Regular.of(size: 11)
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.text = "클라이밍을 기록해주세요."
        textView.font = RobotoFont.Light.of(size: 11)
        textView.textColor = .CLDDarkGray
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
        textView.backgroundColor = .ChipWhite
        textView.layer.addBorder([.bottom], color: UIColor.CLDGold, width: 1.0)
        return textView
    }()
    private let underLine: CALayer = {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 80, width: 337, height: 1)
        border.backgroundColor = UIColor.CLDGold.cgColor
        return border
    }()
    private let reportLabel: UILabel = {
        let label = UILabel()
        label.text = "부적절하거나 불쾌감을 줄 수 있는 컨텐츠는 제재를 받을 수 있습니다"
        label.font = RobotoFont.Light.of(size: 11)
        label.textColor = .CLDDarkGray
        return label
    }()
    
    // 장소
    private let placeRectView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 338, height: 31)
        view.backgroundColor = .CLDLightGray
        return view
    }()
    private let placeIconView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = ImageLiteral.placeIcon
        return iconView
    }()
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.text = "더클라임 강남점"
        label.textColor = .CLDDarkDarkGray
        label.font = RobotoFont.Regular.of(size: 15)
        return label
    }()
    // 섹터
    private let sectorRectView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 338, height: 31)
        view.backgroundColor = .CLDLightGray
        return view
    }()
    private let sectorIconView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = ImageLiteral.STIcon
        return iconView
    }()
    private let sectorLabel: UILabel = {
        let label = UILabel()
        label.text = "7"
        label.textColor = .CLDDarkDarkGray
        label.font = RobotoFont.Regular.of(size: 15)
        return label
    }()
    private let colorRectView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 338, height: 31)
        view.backgroundColor = .CLDLightGray
        return view
    }()
    private let colorIconView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = ImageLiteral.VIcon
        return iconView
    }()
    private lazy var colorCircle: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        view.layer.backgroundColor = UIColor.ChipGreen.cgColor
        view.layer.cornerRadius = 9
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 2
        return view
    }()
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "초록색"
        label.textColor = .CLDDarkDarkGray
        label.font = RobotoFont.Regular.of(size: 15)
        return label
    }()

    private let loadingView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.opacity = 0.7
        view.layer.isHidden = true
        return view
    }()
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        loadingIndicator.color = .CLDGold
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.stopAnimating()

        return loadingIndicator

    }()

    func startLoadingIndicator() {
        loadingIndicator.startAnimating()
        loadingView.isHidden = false
    }
    func stopLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingView.isHidden = true
    }

    func setPostRecord(_ thumbnailImage: UIImage, _ place: String, _ sector: String, _ color: ColorChipName, _ colorText: String) {
        thumbnailView.image = thumbnailImage
        placeLabel.text = place
        sectorLabel.text = sector
        colorLabel.text = colorText
        colorCircle.layer.backgroundColor = color.colorChip()
    }
    func getTextView() -> String {
        let text: String = textView.text
        return text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
        
        textView.delegate = self
        textView.layer.addSublayer((underLine))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        addSubviews(backButton,titleLabel,thumbnailView,textView,placeRectView,sectorRectView,colorRectView,loadingView,loadingIndicator, reportLabel)
        thumbnailView.addSubviews(playIcon,labelBackground)
        labelBackground.addSubview(timeLabel)
        placeRectView.addSubviews(placeIconView,placeLabel)
        sectorRectView.addSubviews(sectorIconView,sectorLabel)
        colorRectView.addSubviews(colorIconView,colorCircle,colorLabel)
    }
    
    func setConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.width.equalTo(10)
            $0.height.equalTo(20)
            $0.leading.equalToSuperview().inset(15)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.centerX.equalToSuperview()
        }
        thumbnailView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(217)
            $0.height.equalTo(212)
        }
        playIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(35)
            $0.height.equalTo(45)
        }
//        labelBackground.snp.makeConstraints {
//            $0.width.equalTo(27)
//            $0.height.equalTo(12)
//            $0.trailing.equalToSuperview().inset(12)
//            $0.bottom.equalToSuperview().inset(8)
//        }
//        timeLabel.snp.makeConstraints {
//            $0.center.equalToSuperview()
//        }
        textView.snp.makeConstraints {
            $0.top.equalTo(thumbnailView.snp.bottom).offset(15)
            $0.width.equalTo(338)
            $0.height.equalTo(81)
            $0.centerX.equalToSuperview()
        }
        
        reportLabel.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        placeRectView.snp.makeConstraints {
            $0.top.equalTo(reportLabel.snp.bottom).offset(30)
            $0.width.equalTo(338)
            $0.height.equalTo(31)
            $0.centerX.equalToSuperview()
        }
        placeIconView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(9)
            $0.width.equalTo(14)
            $0.height.equalTo(18)
            $0.centerY.equalToSuperview()
        }
        placeLabel.snp.makeConstraints {
            $0.leading.equalTo(placeIconView.snp.trailing).offset(13)
            $0.height.equalTo(18)
            $0.centerY.equalToSuperview()
        }
        
        sectorRectView.snp.makeConstraints {
            $0.top.equalTo(placeRectView.snp.bottom).offset(5)
            $0.width.equalTo(338)
            $0.height.equalTo(31)
            $0.centerX.equalToSuperview()
        }
        sectorIconView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(9)
            $0.width.equalTo(21)
            $0.height.equalTo(16)
            $0.centerY.equalToSuperview()
        }
        sectorLabel.snp.makeConstraints {
            $0.leading.equalTo(placeIconView.snp.trailing).offset(13)
            $0.height.equalTo(18)
            $0.centerY.equalToSuperview()
        }
        
        colorRectView.snp.makeConstraints {
            $0.top.equalTo(sectorRectView.snp.bottom).offset(5)
            $0.width.equalTo(338)
            $0.height.equalTo(31)
            $0.centerX.equalToSuperview()
        }
        colorIconView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(9)
            $0.width.equalTo(13)
            $0.height.equalTo(17)
            $0.centerY.equalToSuperview()
        }
        colorCircle.snp.makeConstraints {
            $0.leading.equalTo(placeIconView.snp.trailing).offset(7)
            $0.size.equalTo(18)
            $0.centerY.equalToSuperview()
        }
        colorLabel.snp.makeConstraints {
            $0.leading.equalTo(colorCircle.snp.trailing).offset(10)
            $0.height.equalTo(18)
            $0.centerY.equalToSuperview()
        }

        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension PostRecordView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .CLDDarkGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "클라이밍을 기록해주세요."
            textView.textColor = .CLDDarkGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        let textHeight = textView.contentSize.height
        if (textHeight > 80) {
            underLine.frame = CGRect(x: 0,y: textHeight-2,
                                      width: 337, height: 1)
        }
    }
}
