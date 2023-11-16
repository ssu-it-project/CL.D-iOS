//
//  ClimbingGymVideoViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/09/16.
//

import UIKit

import RxSwift
import RxCocoa

final class ClimbingGymVideoViewController: BaseViewController {
    
    private lazy var contentView = ClimbingGymVideoView()
    
    private var viewModel: ClimbingGymVideoViewModel
    
    init(viewModel: ClimbingGymVideoViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
    }
    
    override func Bind() {
        let input = ClimbingGymVideoViewModel.Input(
            viewWillAppearEvent: rx.viewWillAppear.map { _ in },
            searchText: contentView.searchBar.rx.text.orEmpty.asObservable().debounce(.seconds(1), scheduler: MainScheduler.instance).distinctUntilChanged())
        let output = viewModel.transform(input: input)
        
        output.recordListVO
            .asDriver(onErrorJustReturn: [])
            .drive(with: self) { owner, recordListVO in
                owner.contentView.applyCollectionViewDataSource(by: recordListVO)
            }
            .disposed(by: disposeBag)
        
        output.navigationTitle
            .asDriver(onErrorJustReturn: "")
            .drive(rx.title)
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        contentView.collectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                let data = owner.contentView.itemIdentifier(for: indexPath)
                let playerViewController = PlayerViewController(url: data?.video.original ?? "")
                owner.navigationController?.pushViewController(playerViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        Observable.merge(contentView.searchBar.rx.cancelButtonClicked.asObservable(), contentView.searchBar.rx.cancelButtonClicked.asObservable())
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.contentView.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
}
