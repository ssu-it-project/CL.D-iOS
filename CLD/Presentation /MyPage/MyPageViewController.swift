//
//  MyPageViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/20.
//

import UIKit

import SnapKit

class MyPageViewController: BaseViewController {
    var lableInfo: [String] = ["등반 기록", "방문한 암장", "비디오", "좋아요", "게시글"]
    var countInfo: [Int] = [372, 24, 82, 1002, 6]

    let mypageView = MyPageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        mypageView.countCollectionView.delegate = self
        mypageView.countCollectionView.dataSource = self
        mypageView.badgeCollectionView.delegate = self
        mypageView.badgeCollectionView.dataSource = self
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
        print("=== collectionView: \(collectionView)")
        if collectionView == mypageView.countCollectionView {
            return 5
        }
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mypageView.countCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountCollectionViewCell.identifier, for: indexPath) as! CountCollectionViewCell
            cell.countLabel.text = String(countInfo[indexPath.row])
            cell.nameLabel.text = lableInfo[indexPath.row]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.identifier, for: indexPath) as! HistoryCollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mypageView.countCollectionView {
            return CGSize(width: 72, height: 72)
        }
        return CGSize(width: 352, height: 76)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == mypageView.countCollectionView {
            return 0
        }
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mypageView.countCollectionView {
            print("=== count index: \(indexPath.row)")
        } else {
            print("=== badge index: \(indexPath.row)")
        }
    }
}
