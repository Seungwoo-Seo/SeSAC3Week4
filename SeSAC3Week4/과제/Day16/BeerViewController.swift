//
//  BeerViewController.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/08.
//

import Alamofire
import SwiftyJSON
import Kingfisher
import UIKit

struct Beer {
    let name: String
    let imageString: String
    let description: String

    var imageURL: URL? {
        return URL(string: imageString)
    }
}

final class BeerViewController: UIViewController {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!

    var beer: Beer? {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        fetchData()
    }

    @IBAction func didTapSuggestionButton(_ sender: UIButton) {
        fetchData()
    }
}

private extension BeerViewController {

    func configureHierarchy() {

    }

    func updateUI() {
        beerImageView.kf.setImage(
            with: beer?.imageURL,
            placeholder: UIImage(systemName: "heart.fill")
        )
        beerNameLabel.text = beer?.name
        beerDescriptionLabel.text = beer?.description
    }

}

private extension BeerViewController {

    func fetchData() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.punkapi.com"
        components.path = "/v2/beers/random"

        guard let url = components.url else {return}

        AF
            .request(url, method: .get)
            .validate()
            .responseJSON { [weak self] (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                let name = json[0]["name"].stringValue
                let imageString = json[0]["image_url"].stringValue
                let description = json[0]["description"].stringValue

                self?.beer = Beer(
                    name: name,
                    imageString: imageString,
                    description: description
                )

            case .failure(let error):
                print(error)
            }
        }
    }

}
