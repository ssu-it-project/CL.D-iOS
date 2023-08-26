//
//  RecordViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/20.
//

import UIKit

import SnapKit
import Tabman
import Pageboy

class RecordViewController: TabmanViewController {
    private var viewControllers: Array<BaseViewController> = []
    var tabBarView: UIView!
    var recordDic: Dictionary<String, Any> = [:]
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(nextPageButtonTapped), for: .touchUpInside)
        return button
    }()
    @objc func nextPageButtonTapped() {
        if let currentPage = self.currentIndex, currentPage < viewControllers.count - 1 {
            self.scrollToPage(.next, animated: true)
        }
    }
    private func setUpVC() {
        let firstVC = SelectPlaceViewController()
        let secondVC = SelectSectorViewController()
        let thirdVC = SelectColorViewController()
        let fourthVC = SelectVideoViewController()
        
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        viewControllers.append(thirdVC)
        viewControllers.append(fourthVC)
    }
    private func settingTabBar (ctBar : TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .snap
        ctBar.layout.contentInset = UIEdgeInsets(top: 34.0, left: 21.0, bottom: 0.0, right: 0.0)
        ctBar.layout.interButtonSpacing = 18
        ctBar.backgroundView.style = .flat(color: .white)

        ctBar.buttons.customize { (button) in
            button.tintColor = .CLDMediumGray
            button.selectedTintColor = .CLDGold
            button.font = UIFont(name: "Roboto-Bold", size: 15)!
        }
        ctBar.indicator.weight = .custom(value: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpVC()
        self.dataSource = self

        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar)
        addBar(bar, dataSource: self, at: .top)
        bar.dataSource = self

        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        self.view.addSubview(nextButton)
    }
    
    func setConstraints() {
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(56)
            $0.centerX.equalToSuperview()
        }
    }
}

extension RecordViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return RecordTabItem.place.changeTabItem()
        case 1:
            return RecordTabItem.sector.changeTabItem()
        case 2:
            return RecordTabItem.color.changeTabItem()
        case 3:
            return RecordTabItem.video.changeTabItem()
        default:
            return RecordTabItem.place.changeTabItem()
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        if index == 3 {
            if let nextViewController = viewControllers[index-3] as? SelectPlaceViewController {
                recordDic["place"] = nextViewController.placeText
            }
            if let nextViewController = viewControllers[index-2] as? SelectSectorViewController {
                recordDic["sector"] = nextViewController.sectorText
            }
            if let nextViewController = viewControllers[index-1] as? SelectColorViewController {
                recordDic["color"] = nextViewController.colorInfo
            }
            if let currentViewController = viewControllers[index] as? SelectVideoViewController {
                currentViewController.finalRecordDic = recordDic
            }
            nextButton.isHidden = true
        } else {
            nextButton.isHidden = false
        }
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 0)
    }
}
