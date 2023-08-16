//
//  VideoTableViewCell.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/09.
//

import UIKit

final class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        contentLabel.font = .systemFont(ofSize: 13)
        contentLabel.numberOfLines = 0
        thumbnailImageView.contentMode = .scaleToFill
    }

    func configure(video: Video) {
        titleLabel.text = video.title
        contentLabel.text = video.contents
    }

}
