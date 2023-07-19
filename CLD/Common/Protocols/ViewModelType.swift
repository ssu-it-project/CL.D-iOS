//
//  ViewModelType.swift
//  CLD
//
//  Created by 김규철 on 2023/07/19.
//

import Foundation

import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    var disposeBag: DisposeBag { get set }

    func transform(input: Input) -> Output
}
