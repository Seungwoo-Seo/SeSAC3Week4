//
//  AsyncViewController.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/11.
//

import UIKit

final class AsyncViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        firstImageView.backgroundColor = .black

        print("1")
        DispatchQueue.main.async {
            print("2")
            self.firstImageView.layer.cornerRadius = self.firstImageView.frame.width / 2
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        print("3")
    }


    // sync async serial concurrent
    // UI Freezing 된다고 표현하기도 함

    @IBAction func didTapButton(_ sender: UIButton) {
        // 이런 과정이 귀찮아서 kingfisher를 사용
        let url = URL(
            string: "https://api.nasa.gov/assets/img/general/apod.jpg"
        )!

        DispatchQueue.global(qos: .background).async {
            let data = try! Data(contentsOf: url)

            DispatchQueue.main.async {
                self.firstImageView.image = UIImage(data: data)
            }
        }
    }

}
