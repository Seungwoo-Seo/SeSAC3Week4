//
//  EndPoint.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/11.
//

import Foundation

enum EndPoint {
    case blog
    case cafe
    case video

    var requestURL: String {
        switch self {
        case .blog:
            return URL.makeEndPointString("blog?query=")
        case .cafe:
            return URL.makeEndPointString("cafe?query=")
        case .video:
            return URL.makeEndPointString("vclip?query=")
        }
    }
}
