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
        self.title = viewModel.title
        bindAction()
    }
    
    override func Bind() {
        let input = ClimbingGymVideoViewModel.Input(viewWillAppearEvent: rx.viewWillAppear.map { _ in })
        let output = viewModel.transform(input: input)
        
        output.recordListVO
            .withUnretained(self)
            .bind { owner, recordListVO in
                print("==========", recordListVO)
                owner.contentView.applyCollectionViewDataSource(by: recordListVO)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        contentView.collectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                let data = owner.contentView.itemIdentifier(for: indexPath)
                let playerViewController = PlayerViewController(url: data?.video.video480 ?? "")
                owner.navigationController?.pushViewController(playerViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
