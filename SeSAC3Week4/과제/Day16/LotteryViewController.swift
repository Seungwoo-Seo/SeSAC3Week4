//
//  LotteryViewController.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/08.
//

import Alamofire
import SwiftyJSON
import UIKit

final class LotteryViewController: UIViewController {

    @IBOutlet weak var lotteryTextField: UITextField!
    @IBOutlet weak var lotteryTurnLabel: UILabel!
    @IBOutlet var numberLabels: [UILabel]!

    let pickerView = UIPickerView()

    let turnList: [Int] = Array(1...1079).reversed()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()

        fetchData()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }

}

extension LotteryViewController: UIPickerViewDataSource {

    func numberOfComponents(
        in pickerView: UIPickerView
    ) -> Int {
        return 1
    }

    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return turnList.count
    }

}

extension LotteryViewController: UIPickerViewDelegate {

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        let turn = turnList[row]
        fetchData(turn: turn)
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return "\(turnList[row])"
    }

}

// UI
private extension LotteryViewController {

    func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self

        lotteryTextField.inputView = pickerView
    }

    func configureHierarchy() {
        configurePickerView()
    }

}

// Network
private extension LotteryViewController {

    func fetchData(turn: Int = 1079) {
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

        AF
            .request(url, method: .get)
            .validate()
            .responseJSON { [weak self] (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")

                    let iValues = [
                        json["drwtNo1"].intValue,
                        json["drwtNo2"].intValue,
                        json["drwtNo3"].intValue,
                        json["drwtNo4"].intValue,
                        json["drwtNo5"].intValue,
                        json["drwtNo6"].intValue,
                        json["bnusNo"].intValue
                    ]

                    print(iValues)

                    self?.lotteryTurnLabel.text = "\(turn)회"
                    self?.updateNumberLabel(iValues: iValues)

                case .failure(let error):
                    print(error)
                }
            }
    }

    func updateNumberLabel(iValues: [Int]) {
        for i in 0...6 {
            print(i)
            if i == 6 {
                numberLabels[i].text = "보너스 : \(iValues[i])"
            } else {
                numberLabels[i].text = "\(i+1)번 : \(iValues[i])"
            }
        }
    }

}
