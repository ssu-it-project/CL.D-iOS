//
//  ClimbingGymSearchViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/20.
//

import UIKit

import RxSwift
import RxCocoa

final class ClimbingGymSearchViewController: BaseViewController {
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.delegate = self
        view.placeholder = "검색"
        view.searchBarStyle = .minimal
        return view
    }()
    private let climbingGymSegmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["가까운 암장", "자주 가는 암장"])
        segment.selectedSegmentIndex = 0
        return segment
    }()
    private lazy var climbingGymTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 120
        view.register(ClimbingGymTableViewCell.self, forCellReuseIdentifier: "ClimbingGymTableViewCell")
        return view
    }()
    
    private var dummyArray: [ClimbingGym] = [ClimbingGym(id: "aa", location: Location(distance: 2, x: 3, y: 4), place: Place(addressName: "서울시 동대문구 회기동", name: "더 클라이밍 연남", parking: true, roadAddressName: "서울시 동대문구 회기동 조흔 곳", shower: true), type: "aa"), ClimbingGym(id: "aa", location: Location(distance: 2, x: 3, y: 4), place: Place(addressName: "서울시 동대문구 회기동", name: "더 클라이밍 연남", parking: true, roadAddressName: "서울시 동대문구 회기동 조흔 곳", shower: true), type: "aa"), ClimbingGym(id: "aa", location: Location(distance: 2, x: 3, y: 4), place: Place(addressName: "서울시 동대문구 회기동", name: "더 클라이밍 연남", parking: true, roadAddressName: "서울시 동대문구 회기동 조흔 곳", shower: true), type: "aa"), ClimbingGym(id: "aa", location: Location(distance: 2, x: 3, y: 4), place: Place(addressName: "서울시 동대문구 회기동", name: "더 클라이밍 연남", parking: true, roadAddressName: "서울시 동대문구 회기동 조흔 곳", shower: true), type: "aa"), ClimbingGym(id: "aa", location: Location(distance: 2, x: 3, y: 4), place: Place(addressName: "서울시 동대문구 회기동", name: "더 클라이밍 연남", parking: true, roadAddressName: "서울시 동대문구 회기동 조흔 곳", shower: true), type: "aa")]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "암장 검색"
    }
    
    override func Bind() {
        Driver<[ClimbingGym]>
            .just(dummyArray)
            .drive(climbingGymTableView.rx.items) { tableView, index, menu in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClimbingGymTableViewCell", for: IndexPath(row: index, section: 0)) as? ClimbingGymTableViewCell else { return UITableViewCell() }
                return cell
            }
            .disposed(by: disposeBag)
    }
        
    override func setHierarchy() {
        [searchBar, climbingGymSegmentControl, climbingGymTableView].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
            make.leading.trailing.equalToSuperview().inset(19)
            make.height.equalTo(27)
        }
        
        climbingGymSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(17)
            make.leading.equalToSuperview().inset(19)
        }
        
        climbingGymTableView.snp.makeConstraints { make in
            make.top.equalTo(climbingGymSegmentControl.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func setViewProperty() {
        super.setViewProperty()
    }
}

extension ClimbingGymSearchViewController: UISearchBarDelegate {
    
}
