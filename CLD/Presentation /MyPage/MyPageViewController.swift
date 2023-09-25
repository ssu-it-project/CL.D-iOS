//
//  MyPageViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/20.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class MyPageViewController: BaseViewController {
    var data_All: [History] = []
    lazy var dataTarget: [History] = []
    var dataCount: Int = 0
    let lableInfo: [String] = ["등반 기록", "방문한 암장", "비디오", "좋아요", "게시글"]
    var countInfo: [Int] = [372, 24, 82, 1002, 6]
    let categoryLabels: [String] = ["전체", "등반기록", "뱃지"]
    let dummyData_All: [[Any]] = [["돌잡이들의 왕", "2023.6.05 뱃지 획득", ImageLiteral.testBadgeImage, "novideo"],["더 클라이밍 마곡", "2023.6.20 | A섹터 | 보라색", ImageLiteral.holderPurple, "video"], ["더 클라이밍 마곡", "2023.6.20 | C섹터 | 파랑색", ImageLiteral.holderBlue, "video"], ["더 클라이밍 마곡", "2023.6.20 | C섹터 | 파란색", ImageLiteral.holderBlue, "video"], ["더 클라이밍 마곡", "2023.6.20 | 5섹터 | 주황색", ImageLiteral.holderOrange, "video"]]
    let dummyData_Record: [[Any]] = [["더 클라이밍 마곡", "2023.6.20 | A섹터 | 보라색", ImageLiteral.holderPurple, "video"], ["더 클라이밍 마곡", "2023.6.20 | C섹터 | 파랑색", ImageLiteral.holderBlue, "video"], ["더 클라이밍 마곡", "2023.6.20 | C섹터 | 파란색", ImageLiteral.holderBlue, "video"], ["더 클라이밍 마곡", "2023.6.20 | 5섹터 | 주황색", ImageLiteral.holderOrange, "video"]]
    let dummyData_Badge: [[Any]] = [["돌잡이들의 왕", "2023.6.05 뱃지 획득", ImageLiteral.testBadgeImage, "novideo"]]

    let mypageView = MyPageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        mypageView.delegatePushSetting = self
        mypageView.countCollectionView.delegate = self
        mypageView.countCollectionView.dataSource = self
        mypageView.badgeCollectionView.delegate = self
        mypageView.badgeCollectionView.dataSource = self
        mypageView.categoryCollectionView.delegate = self
        mypageView.categoryCollectionView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        getUser()
        getUserHistory(type: "" , start_date: "" , end_date: "", limit: 10, skip: 0)
    }
    override func setHierarchy() {
        self.view.addSubview(mypageView)
    }

    override func setConstraints() {
        mypageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MyPageViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                                 UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mypageView.countCollectionView {
            return lableInfo.count
        } else if collectionView == mypageView.badgeCollectionView {
            return dataCount-1
        } else if collectionView == mypageView.categoryCollectionView {
            return categoryLabels.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mypageView.countCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountCollectionViewCell.identifier, for: indexPath) as! CountCollectionViewCell
            cell.countLabel.text = String(countInfo[indexPath.row])
            cell.nameLabel.text = lableInfo[indexPath.row]
            return cell
        } else if collectionView == mypageView.badgeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.identifier, for: indexPath) as! HistoryCollectionViewCell
            print("===== indexPath: \(indexPath.row) ")
            cell.titleLabel.text = data_All[indexPath.row].record.gymName
            cell.dateLabel.text = data_All[indexPath.row].historyDate
            cell.badgeImageView.image = ImageLiteral.holderBlue
            if (data_All[indexPath.row].type == "record"){
                cell.videoIcon.image = ImageLiteral.videoIcon
                cell.cellBackgroundView.backgroundColor = .CLDLightGray
                cell.titleLabel.textColor = .CLDBlack
                cell.dateLabel.textColor = .CLDMediumGray
            } else {
                cell.videoIcon.image = nil
                cell.cellBackgroundView.backgroundColor = .CLDGold
                cell.titleLabel.textColor = .white
                cell.dateLabel.textColor = .white
            }
            return cell
        } else if collectionView == mypageView.categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            mypageView.categoryCollectionView.selectItem(at: [0,0], animated: false, scrollPosition: .init())
            cell.setCategory(text: categoryLabels[indexPath.row])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.identifier, for: indexPath) as! HistoryCollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mypageView.countCollectionView {
            return CGSize(width: 72, height: 72)
        } else if collectionView == mypageView.badgeCollectionView {
            return CGSize(width: 352, height: 76)
        } else if collectionView == mypageView.categoryCollectionView {
            let categoryLabel: UILabel = {
                let label = UILabel()
                label.text = categoryLabels[indexPath.row]
                label.textColor = .CLDBlack
                label.font = RobotoFont.Bold.of(size: 14)
                label.textAlignment = .center
                label.sizeToFit()

                return label
            }()
            let size = categoryLabel.frame.size
            return CGSize(width: size.width + 4, height: size.height)
        }
        return CGSize(width: 0, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == mypageView.countCollectionView {
            return 0
        } else if collectionView == mypageView.badgeCollectionView {
            return 8
        } else if collectionView == mypageView.categoryCollectionView {
            return 2
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        if collectionView == mypageView.countCollectionView {
            print("=== count index: \(indexPath.row)")
        } else if collectionView == mypageView.badgeCollectionView {
            print("=== badge index: \(indexPath.row)")
        } else if collectionView == mypageView.categoryCollectionView {
            print("=== category index: \(indexPath.row)")
            if (index == 0) {
                getUserHistory(type: "" , start_date: "" , end_date: "", limit: 10, skip: 0)
            } else if (index == 1) {
                getUserHistory(type: "clime_record" , start_date: "" , end_date: "", limit: 10, skip: 0)
            } else {
                getUserHistory(type: "badge" , start_date: "" , end_date: "", limit: 10, skip: 0)
            }
        }
    }
}

extension MyPageViewController: PushSettingDelegate {
    func settingButtonTapped() {
        let nextViewController = SettingViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension MyPageViewController {
    private func getUser() {
        NetworkService.shared.myPage.getUser() { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? UserDTO else { return }
                self!.mypageView.setProfile(imageUrl: data.profile.image, nickname: data.profile.nickname)

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
    private func getUserHistory(type: String, start_date: String, end_date: String, limit: Int, skip: Int) {
        NetworkService.shared.myPage.getUserHistory(type: type, start_date: start_date, end_date: end_date, limit: limit, skip: skip) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? UserHistoryDTO else { return }
                self!.data_All = data.histories
                self!.dataCount = data.pagination.total
    
                print("===== histoty: \(self!.data_All)")
                print("===== count: \(self!.dataCount)")

                self!.mypageView.badgeCollectionView.reloadData()

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
