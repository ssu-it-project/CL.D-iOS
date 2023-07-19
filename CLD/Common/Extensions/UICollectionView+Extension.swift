//
//  UICollectionView+Extension.swift
//  CLD
//
//  Created by 김규철 on 2023/07/18.
//

import UIKit

extension UICollectionReusableView: ReusableView {}

/*
 
사용방법
 
let cell: TestCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
 let header = collectionView.dequeueHeaderView(type: SectionHeaderReusableView.self, forIndexPath: indexPath)
 
*/

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T
        else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueHeaderView<T: UICollectionReusableView>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return view
    }

    func dequeueFooterView<T: UICollectionReusableView>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return view
    }

    func restore() {
        backgroundView = nil
    }

    func register<T>(
        cell: T.Type,
        forCellWithReuseIdentifier reuseIdentifier: String = T.reuseIdentifier
    ) where T: UICollectionViewCell {
        register(cell, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func registerHeaderView<T>(
        view: T.Type,
        forCellWithReuseIdentifier reuseIdentifier: String = T.reuseIdentifier
    ) where T: UICollectionReusableView {
        register(view, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
    }
    
    func registerFooterView<T>(
        view: T.Type,
        forCellWithReuseIdentifier reuseIdentifier: String = T.reuseIdentifier
    ) where T: UICollectionReusableView {
        register(view, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifier)
    }
}
