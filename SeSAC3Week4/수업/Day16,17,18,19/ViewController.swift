//
//  ViewController.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/07.
//

import Alamofire
import SwiftyJSON
import UIKit

struct Movie {
    var title: String
    var release: String

}

final class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!


    var movieList: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        movieTableView.rowHeight = 60
        movieTableView.delegate = self
        movieTableView.dataSource = self
        indicatorView.isHidden = true
    }

    func fetchData(data: String) {
        indicatorView.startAnimating()
        indicatorView.isHidden = false

        var components = URLComponents()
        components.scheme = "https"
        components.host = "kobis.or.kr"
        components.path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        components.queryItems = [
            URLQueryItem(name: "key", value: APIKey.boxOffice),
            URLQueryItem(name: "targetDt", value: "20031111")
        ]
        let url = components.url!

        AF
            .request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")

                    let name1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
                    let name2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
                    let name3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue


                    for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                        let movieNm = item["movieNm"].stringValue
                        let openDt = item["openDt"].stringValue

                        let movie = Movie(
                            title: movieNm,
                            release: openDt
                        )

                        self.movieList.append(movie)
                    }


                    self.indicatorView.stopAnimating()
                    self.indicatorView.isHidden = true
                    self.movieTableView.reloadData()


                case .failure(let error):
                    print(error)
                }
            }
    }

}

extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchData(data: searchBar.text!)
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return movieList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "movieCell",
            for: indexPath
        )

        cell.textLabel?.text = movieList[indexPath.row].title
        cell.detailTextLabel?.text = movieList[indexPath.row].release

        return cell
    }

}

extension ViewController: UITableViewDelegate {

}


