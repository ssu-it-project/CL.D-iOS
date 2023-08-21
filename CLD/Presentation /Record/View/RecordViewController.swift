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
    var recordDic: Dictionary<String, Any> = [:]
    
    private var viewControllers: Array<BaseViewController> = []
    var tabBarView: UIView!
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(RecordViewController.self, action: #selector(nextPageButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
        // 왼쪽 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 34.0, left: 21.0, bottom: 0.0, right: 0.0)
        // 간격
        ctBar.layout.interButtonSpacing = 18
        ctBar.backgroundView.style = .flat(color: .white)
        
        // 선택 / 안선택 색 + font size
        ctBar.buttons.customize { (button) in
            button.tintColor = .CLDMediumGray
            button.selectedTintColor = .CLDGold
            button.font = UIFont(name: "Roboto-Bold", size: 15)!
        }
        
        // 인디케이터 (영상에서 주황색 아래 바 부분)
        ctBar.indicator.weight = .custom(value: 0)
    }
    
    @objc func nextPageButtonTapped() {
        if let currentPage = self.currentIndex, currentPage < viewControllers.count - 1 {
            // 현재 페이지의 인덱스를 가져와서 페이지를 1 증가시켜 다음 페이지로 전환
            self.scrollToPage(.next, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpVC()
        self.dataSource = self
        
        
        // Create bar
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar)
        addBar(bar, dataSource: self, at: .top)
        
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
            $0.width.equalTo(28)
            $0.height.equalTo(18)
        }
    }
}

extension RecordViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "클라이밍장")
        case 1:
            return TMBarItem(title: "섹터")
        case 2:
            return TMBarItem(title: "난이도 색상")
        case 3:
            return TMBarItem(title: "영상")
        default:
            return TMBarItem(title: "클라이밍장")
        }
        
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        if index == 3 {
            nextButton.isHidden = true
            if let nextViewController = viewControllers[index-3] as? SelectPlaceViewController {
                recordDic["place"] = nextViewController.placeText
            }
            if let nextViewController = viewControllers[index-2] as? SelectSectorViewController {
                recordDic["sector"] = nextViewController.sectorText
            }
            if let nextViewController = viewControllers[index-1] as? SelectColorViewController {
                recordDic["color"] = nextViewController.colorText
            }
            if let currentViewController = viewControllers[index] as? SelectVideoViewController {
                currentViewController.finalRecordDic = recordDic
            }
        } else {
            nextButton.isHidden = false
        }
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 0)
    }
}


