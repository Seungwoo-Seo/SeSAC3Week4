//
//  TranslateAPIManager.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/11.
//

import Alamofire
import SwiftyJSON
import Foundation

final class TranslateAPIManager {

    static let shared = TranslateAPIManager()

    private init() {}

    let header: HTTPHeaders = []

    func fetchData(
        text: String,
        completion: @escaping (String) -> ()
    ) {
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverClientId,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ]

        let parameters: Parameters = [
            "source": "ko",
            "target": "en",
            "text": text
        ]

        let url = URL(
            string: "https://openapi.naver.com//v1/papago/detectLangs"
        )!

        AF
            .request(
                url,
                method: .post,
                parameters: parameters,
                headers: headers
            )
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let result = json["message"]["result"]["translatedText"].stringValue
                    completion(result)

                case .failure(let error):
                    print(error)
                }
            }
    }

}
