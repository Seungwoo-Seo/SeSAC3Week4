//
//  KakaoAPIManager.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/11.
//

import Alamofire
import Foundation

final class KakaoAPIManager {

    static let shared = KakaoAPIManager()

    private init() {}

    let header: HTTPHeaders = ["Authorization": APIKey.kakao]

    func fetchData(
        type: EndPoint,
        query: String,
        completion: @escaping (VideoContainer?) -> ()
    ) {
        // 한글 인코딩 방법
        guard let query = query.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else {return}

        let url = type.requestURL + query

        AF
            .request(
                url,
                method: .get,
                headers: header
            )
            .validate(statusCode: 200...500)
            .responseDecodable(
                of: VideoContainer.self
            ) { response in
                completion(response.value)
            }
    }

}
