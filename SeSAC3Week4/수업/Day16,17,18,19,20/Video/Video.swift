//
//  Video.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/16.
//

import Foundation

struct VideoContainer: Decodable {
    let videoList: [Video]
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case videoList = "documents"
        case meta
    }
}

struct Video: Decodable {
    let author: String
    let date: String
    let time: Int
    let thumbnail: String
    let title: String
    let link: String

    var contents: String {
        return "\(author) | \(time)회\n\(date)"
    }

    var thumbnailURL: URL? {
        return URL(string: thumbnail)
    }

    enum CodingKeys: String, CodingKey {
        case author
        case date = "datetime"
        case time = "play_time"
        case thumbnail
        case title
        case link = "url"
    }
}

struct Meta: Decodable {
    let isEnd: Bool
    let pageableCount: Int
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
