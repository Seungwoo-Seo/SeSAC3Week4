//
//  TranslationViewController.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/07.
//

import Alamofire
import SwiftyJSON
import UIKit

final class TranslationViewController: UIViewController {

    @IBOutlet weak var originalTextView: UITextView!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var translateTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        translateTextView.isEditable = false
    }


    @IBAction func requestButtonClicked(_ sender: UIButton) {
        detectLanguageAPI(query: originalTextView.text)
    }

}

private extension TranslationViewController {

    func configureHierarchy() {

    }

}

// 네트워킹
private extension TranslationViewController {

    func detectLanguageAPI(query: String) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "openapi.naver.com"
        components.path = "/v1/papago/detectLangs"

        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverClientId,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ]
        let parameters: Parameters = [
            "query": query
        ]

        guard let url = components.url else {return}

        AF
            .request(
                url,
                method: .post,
                parameters: parameters,
                headers: headers
            )
            .validate()
            .responseJSON { [weak self] (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                let source = json["langCode"].string
                self?.papagoTranslationAPI(source: source)

            case .failure(let error):
                print(error)
            }
        }
    }

    func papagoTranslationAPI(source: String?) {
        guard let source = source else {return}

        var components = URLComponents()
        components.scheme = "https"
        components.host = "openapi.naver.com"
        components.path = "/v1/papago/n2mt"

        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverClientId,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": "en",
            "text": originalTextView.text ?? ""
        ]

        guard let url = components.url else {return}

        AF
            .request(
                url,
                method: .post,
                parameters: parameters,
                headers: headers
            )
            .validate()
            .responseJSON { [weak self] (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)

                let data = json["message"]["result"]["translatedText"].stringValue
                self?.translateTextView.text = data

            case .failure(let error):
                print(error)
            }
        }
    }

}
