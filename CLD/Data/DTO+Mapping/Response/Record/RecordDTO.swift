import Foundation

struct RecordListDTO: Decodable {
    let pagination: Pagination
    let records: [RecordDTO]?
    
    enum CodingKeys: String, CodingKey {
        case pagination
        case records = "Records"
    }
}

struct RecordDTO: Decodable {
    let author: AuthorDTO
    let climbingGymInfo: ClimbingGymInfoDTO
    let content: String
    let date: DateClassDTO
    let id, image, level: String
    let likeCount: Int
    let sector: String
    let video: String
    let viewCount: Int

    enum CodingKeys: String, CodingKey {
        case author
        case climbingGymInfo = "climbing_gym_info"
        case content, date, id, image, level
        case likeCount = "like_count"
        case sector, video
        case viewCount = "view_count"
    }
}

struct AuthorDTO: Decodable {
    let id, nickname, profileImage: String

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case profileImage = "profile_image"
    }
}

struct ClimbingGymInfoDTO: Decodable {
    let id, name: String
}

struct DateClassDTO: Decodable {
    let created, modified: String
}

extension RecordListDTO {
    func toDomain() -> RecordListVO {
        return RecordListVO(pagination: PaginationVO(total: pagination.total, skip: pagination.skip, limit: pagination.limit), records: records?.map { $0.toDomain() } ?? [] )
    }
}

extension RecordDTO {
    func toDomain() -> RecordVO {
        return RecordVO(author: author.toDomain(), climbingGymInfo: climbingGymInfo.toDomain(), content: content, date: date.toDomain(), id: id, image: image, level: level, likeCount: likeCount, sector: sector, video: video, viewCount: viewCount)
    }
}

extension AuthorDTO {
    func toDomain() -> AuthorVO {
        return AuthorVO(id: id, nickname: nickname, profileImage: profileImage)
    }
}

extension ClimbingGymInfoDTO {
    func toDomain() -> ClimbingGymInfoVO {
        return ClimbingGymInfoVO(id: id, name: name)
    }
}

extension DateClassDTO {
    func toDomain() -> DateClassVO {
        return DateClassVO(created: created, modified: modified)
    }
}
