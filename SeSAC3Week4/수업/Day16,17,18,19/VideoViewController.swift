//
//  VideoViewController.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/08.
//

import Alamofire
import SwiftyJSON
import Kingfisher
import UIKit

struct Video {
    let author: String
    let date: String
    let time: String
    let thumbnail: String
    let titie: String
    let link: String

    var contents: String {
        return "\(author) | \(time)회\n\(date)"
    }

    var thumbnailURL: URL? {
        return URL(string: thumbnail)
    }
}

final class VideoViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var videoList: [Video] = []
    var page = 1
    var isEnd = false // 현재 페이지가 마지막 페이지인지 점검하는 프로퍼티

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 140

//        fetchData(query: "고양이")
    }

    // invalidURL(url: "https://dapi.kakao.com/v2/search/vclip?query=수박")
    // url에서 한글 처리를 해줘야함 앙ㄴ그러면 이렇게 댐
    // 인섬니아는 알아서 처리를 해둔거

    func fetchData(query: String, page: Int) {
        // 한글 인코딩 방법
        guard let query = query.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else {return}

        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(query)&size=30&page=\(page)"
        let header: HTTPHeaders = [
            "Authorization": APIKey.kakao
        ]

        AF
            .request(
                url,
                method: .get,
                headers: header
            )
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")

                    print(response.response?.statusCode)

                    let statusCode = response.response?.statusCode ?? 500

                    if statusCode == 200 {

                        self.isEnd = json["meta"]["is_end"].boolValue

                        for item in json["documents"].arrayValue {
                            let author = item["author"].stringValue
                            let title = item["title"].stringValue
                            let time = item["play_time"].stringValue
                            let date = item["datetime"].stringValue
                            let thumbnail = item["thumbnail"].stringValue
                            let link = item["url"].stringValue

                            let data = Video(
                                author: author,
                                date: date,
                                time: time,
                                thumbnail: thumbnail,
                                titie: title,
                                link: link
                            )

                            self.videoList.append(data)
                        }

                        print(self.videoList.count)
                        self.tableView.reloadData()

                    } else {
                        print("문제가 발생했어요. 잠시 후 다시 시도해주세요!!!")
                    }

                case .failure(let error):
                    print(error)
                }
            }
    }

}

extension VideoViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1 // 새로운 검색어이기 때문에 page를 1로 변경
        videoList.removeAll()

        guard let query = searchBar.text else {return}
        fetchData(query: query, page: page)
    }

}

extension VideoViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return videoList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: VideoTableViewCell.identifier,
            for: indexPath
        ) as! VideoTableViewCell

        let video = videoList[indexPath.row]
        cell.titleLabel.text = video.titie
        cell.contentLabel.text = video.contents

        if let url = URL(string: video.thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }

        return cell
    }

}

extension VideoViewController: UITableViewDelegate {

}

// UITableViewDataSourcePrefetching: iOS 10이상 사용 가능한 프로토콜
extension VideoViewController: UITableViewDataSourcePrefetching {

    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(
        _ tableView: UITableView,
        prefetchRowsAt indexPaths: [IndexPath]
    ) {
        print(indexPaths)
        for indexPath in indexPaths {
            if videoList.count - 1 == indexPath.row && page < 15 && isEnd == false {
                page += 1
                fetchData(query: searchBar.text!, page: page)
            }
        }
    }

    // 취소 기능: 직접 취소하는 기능을 구현해주어야 함!
    func tableView(
        _ tableView: UITableView,
        cancelPrefetchingForRowsAt indexPaths: [IndexPath]
    ) {
        print("===취소: \(indexPaths)")
    }

}

private extension VideoViewController {


}
