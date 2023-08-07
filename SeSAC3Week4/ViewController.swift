//
//  ViewController.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/07.
//

import Alamofire
import SwiftyJSON
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        fetchData()
    }

    func fetchData() {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20031111"
        AF
            .request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")

                case .failure(let error):
                    print(error)
                }
            }
    }

}

