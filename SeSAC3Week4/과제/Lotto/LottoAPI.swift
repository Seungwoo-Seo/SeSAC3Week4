//
//  LottoAPI.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/09/13.
//

import Alamofire
import Foundation

final class LottoAPI {
    private init() {}
    static let shared = LottoAPI()

    func request(
        turn: Int,
        completion: @escaping (Lotto) -> ()
    ) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.dhlottery.co.kr"
        components.path = "/common.do"
        components.queryItems = [
            URLQueryItem(
                name: "method",
                value: "getLottoNumber"
            ),
            URLQueryItem(
                name: "drwNo",
                value: "\(turn)"
            )
        ]

        guard let url = components.url else {return}

        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let lotto):
                    print(lotto)
                    completion(lotto)

                case .failure(let error):
                    print(error)
                }
            }
    }

}
