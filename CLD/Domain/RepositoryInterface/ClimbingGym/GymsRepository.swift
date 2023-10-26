//
//  GymsRepository.swift
//  CLD
//
//  Created by 김규철 on 2023/09/14.
//

import RxSwift

protocol GymsRepository: AnyObject {
    func getLocationGyms(latitude: Double, longitude: Double, keyword: String, limit: Int, skip: Int) -> Single<GymsVO>
    func getDetailGym(id: String) -> Single<DetailGymVO>
    func getDetailGymRecord(id: String, keyword: String, limit: Int, skip: Int) -> Single<RecordListVO>
    func getBookmarkGym(keyword: String, limit: Int, skip: Int) -> Single<BookmarkGymsVO>
    func postBookmark(id: String) -> Single<Void>
}
