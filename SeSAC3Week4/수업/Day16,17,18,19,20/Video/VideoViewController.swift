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

final class VideoViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var videoList: [Video] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var page = 1
    var isEnd = false // 현재 페이지가 마지막 페이지인지 점검하는 프로퍼티

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 140
    }

}

extension VideoViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(
        _ searchBar: UISearchBar
    ) {
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
        ) as? VideoTableViewCell

        let video = videoList[indexPath.row]
        cell?.configure(video: video)

        if let url = URL(string: video.thumbnail) {
            cell?.thumbnailImageView.kf.setImage(with: url)
        }

        return cell ?? UITableViewCell()
    }

}

// UITableViewDataSourcePrefetching: iOS 10이상 사용 가능한 프로토콜
extension VideoViewController: UITableViewDataSourcePrefetching {

    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(
        _ tableView: UITableView,
        prefetchRowsAt indexPaths: [IndexPath]
    ) {
        for indexPath in indexPaths {
            if videoList.count - 1 == indexPath.row && page < 15 && isEnd == false {
                page += 1
                fetchData(
                    query: searchBar.text!,
                    page: page
                )
            }
        }
    }

}

// Networking
extension VideoViewController {

    // invalidURL(url: "https://dapi.kakao.com/v2/search/vclip?query=수박")
    // url에서 한글 처리를 해줘야함 앙ㄴ그러면 이렇게 댐
    // 인섬니아는 알아서 처리를 해둔거
    func fetchData(query: String, page: Int) {
        KakaoAPIManager.shared.fetchData(
            type: .video,
            query: query
        ) { [weak self] (container) in
            guard let container else {return}
            self?.isEnd = container.meta.isEnd
            self?.videoList += container.videoList
        }
    }

}
