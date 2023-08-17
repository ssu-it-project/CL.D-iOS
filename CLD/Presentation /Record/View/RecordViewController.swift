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
    // var recordDic: [String: String] = ["place":"", "sector":"", "color":"", "video":""]
    
    private var viewControllers: Array<BaseViewController> = []
    var tabBarView: UIView!
    var tabIndex: Int = 0
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(nextView), for: .touchUpInside)
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
    
    @objc private func nextView () {
        // viewController(for : ., at: 2)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpVC()
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar) //함수 추후 구현
        addBar(bar, dataSource: self, at: .top)
    }
    
    func setHierarchy() {
        self.view.addSubviews(tabBarView, nextButton)
    }
    
    func setConstraints() {
        tabBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(21)
            $0.width.equalTo(225)
            $0.height.equalTo(16)
        }
        nextButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(21)
        }
    }
}

extension RecordViewController: PageboyViewControllerDataSource, TMBarDataSource, selectVCDelegate {
    
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
        tabIndex = index
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 0)
    }

    func nextVC(_ viewController: SelectPlaceViewController, index: Int) {
        print("nextVC")
//        func bar(_ bar: TMBar, didRequestScrollTo index: Int) {
//            print("delegate bar")
//        }
    }
    
    
}


