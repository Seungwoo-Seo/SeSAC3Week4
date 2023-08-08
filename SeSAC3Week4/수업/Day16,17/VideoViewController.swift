//
//  VideoViewController.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/08.
//

import Alamofire
import SwiftyJSON
import UIKit

final class VideoViewController: UIViewController {

    var videoList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }

    // invalidURL(url: "https://dapi.kakao.com/v2/search/vclip?query=수박")
    // url에서 한글 처리를 해줘야함 앙ㄴ그러면 이렇게 댐
    // 인섬니아는 알아서 처리를 해둔거

    func fetchData() {
        // 한글 인코딩 방법
        let text = "아이유".addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        )!
        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)"
        let header: HTTPHeaders = ["Authorization": APIKey.kakao]
        AF
            .request(
                url,
                method: .get,
                headers: header
            )
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")

                    for item in json["documents"].arrayValue {
                        let title = item["title"].stringValue
                        self.videoList.append(title)
                    }

                case .failure(let error):
                    print(error)
                }
            }
    }

}

private extension VideoViewController {


}
