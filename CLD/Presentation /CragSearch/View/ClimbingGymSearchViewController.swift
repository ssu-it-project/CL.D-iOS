//
//  ClimbingGymSearchViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/20.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

final class ClimbingGymSearchViewController: BaseViewController {
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
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
        view.showsVerticalScrollIndicator = false
        view.register(ClimbingGymTableViewCell.self, forCellReuseIdentifier: "ClimbingGymTableViewCell")
        return view
    }()
    
    private let viewModel: ClimbingGymSearchViewModel
    
    init(viewModel: ClimbingGymSearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "암장 검색"
        
        if #available(iOS 16.0, *) {
            self.navigationItem.leftBarButtonItem?.isHidden = true
        }
    }
    
    override func Bind() {
        let input = ClimbingGymSearchViewModel.Input(viewDidLoadEvent: Observable.just(()).asObservable(), viewWillAppearEvent: rx.viewWillAppear.map { _ in } )
        let output = viewModel.transform(input: input)
        
        output.authorizationAlertShouldShow
            .withUnretained(self)
            .bind { owner, bool in
                print("권한 상태", bool)
            }
            .disposed(by: disposeBag)
        
        output.currentUserLocation
            .bind { coordinator in
                print("최종으로 뷰컨에서 나오는 \(coordinator)")
            }
            .disposed(by: disposeBag)
        
        let climbingGymsDriver = output.climbingGymData.asDriver(onErrorJustReturn: [])
        
        climbingGymsDriver
            .drive(climbingGymTableView.rx.items) { tableView, index, gym in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClimbingGymTableViewCell", for: IndexPath(row: index, section: 0)) as? ClimbingGymTableViewCell else { return UITableViewCell() }
                cell.configCell(row: gym)
                return cell
            }
            .disposed(by: disposeBag)
        
        Observable.zip(climbingGymTableView.rx.modelSelected(ClimbingGymVO.self), climbingGymTableView.rx.itemSelected)
            .bind { [weak self] ( item, indexPath) in
                let detailViewController = ClimbingGymDetailViewController(viewModel: ClimbingGymDetailViewModel(id: item.id, useCase: DefaultClimbingGymDetailUseCase(gymsRepository: DefaultGymsRepository())))
                self?.navigationController?.pushViewController(detailViewController, animated: true)
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.leading.trailing.equalToSuperview().inset(19)
            make.height.equalTo(40)
        }
        
        climbingGymSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(19)
            make.height.equalTo(searchBar.snp.height).multipliedBy(0.8)
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
