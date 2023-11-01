//
//  RecordService.swift
//  CLD
//
//  Created by 이조은 on 2023/08/30.
//

import Foundation
import Alamofire

struct PostRecordService {
    static let shared = PostRecordService()

    func postRecord(climbing_gym_id: String,
                    content: String,
                    sector: String,
                    level: String,
                    video: URL,
                    resolution: String,
                    completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URL(string: "https://cl-d.com/api/clime/record")!
        let header: HTTPHeaders = [ "Content-Type": "multipart/form-data",
                                    "Authorization": "Bearer \(UserDefaultHandler.accessToken)"]
        let parameters: [String: Any] = [
            "climbing_gym_id": climbing_gym_id,
            "content": content,
            "sector": sector,
            "level": level,
            "video": video,
            "resolution": resolution
        ]

        print("===video: \(video)")
        //multipart 업로드
        AF.upload(multipartFormData: { (multipart) in
            for (key, value) in parameters {
                multipart.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
            }
            multipart.append(video,
                             withName: "video",
                             fileName: "video.mov",
                             mimeType: "video/mov")
        }, to: url, method: .post, headers: header)
        .responseJSON(completionHandler: { (response) in
            if let err = response.error{
                print(err)
                completion(.requestErr(response))
                return
            }
            completion(.success(response))
        })
    }
}
