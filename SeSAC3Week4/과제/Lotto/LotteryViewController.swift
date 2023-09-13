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
    // MARK: - View
    @IBOutlet weak var lotteryTextField: UITextField!
    @IBOutlet weak var lotteryTurnLabel: UILabel!
    @IBOutlet weak var number1Label: UILabel!
    @IBOutlet weak var number2Label: UILabel!
    @IBOutlet weak var number3Label: UILabel!
    @IBOutlet weak var number4Label: UILabel!
    @IBOutlet weak var number5Label: UILabel!
    @IBOutlet weak var number6Label: UILabel!
    @IBOutlet weak var bnusLabel: UILabel!
    @IBOutlet weak var firstWinLabel: UILabel!
    private let pickerView = UIPickerView()

    // MARK: - ViewModel
    let viewModel = LottoViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        bind()

        // 최초 1회만 데이터 패치
        viewModel.fetchToLotto()
    }

    // MARK: - Event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }

}

// MARK: - UIPickerViewDataSource
extension LotteryViewController: UIPickerViewDataSource {

    func numberOfComponents(
        in pickerView: UIPickerView
    ) -> Int {
        return viewModel.numberOfComponents
    }

    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return viewModel.numberOfRowsInComponent
    }

}

// MARK: - UIPickerViewDelegate
extension LotteryViewController: UIPickerViewDelegate {

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        viewModel.fetchToLotto(row: row)
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return viewModel.titleForRow(row)
    }

}

// MARK: - UI
private extension LotteryViewController {

    func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    func configureLotteryTextFiel() {
        lotteryTextField.inputView = pickerView
    }

    func configureHierarchy() {
        configurePickerView()
        configureLotteryTextFiel()
    }

}

// MARK: - Bind
private extension LotteryViewController {

    func bind() {
        viewModel.turn.bind { [weak self] (turn) in
            guard let self else {return}
            self.lotteryTurnLabel.text = "\(turn)회차"
        }
        viewModel.number1.bind { [weak self] (num) in
            guard let self else {return}
            self.number1Label.text = "1번: \(num)"
        }
        viewModel.number2.bind { [weak self] (num) in
            guard let self else {return}
            self.number2Label.text = "2번: \(num)"
        }
        viewModel.number3.bind { [weak self] (num) in
            guard let self else {return}
            self.number3Label.text = "3번: \(num)"
        }
        viewModel.number4.bind { [weak self] (num) in
            guard let self else {return}
            self.number4Label.text = "4번: \(num)"
        }
        viewModel.number5.bind { [weak self] (num) in
            guard let self else {return}
            self.number5Label.text = "5번: \(num)"
        }
        viewModel.number6.bind { [weak self] (num) in
            guard let self else {return}
            self.number6Label.text = "6번: \(num)"
        }
        viewModel.bnus.bind { [weak self] (bnus) in
            guard let self else {return}
            self.bnusLabel.text = "보너스: \(bnus)"
        }
        viewModel.firstWin.bind { [weak self] (firstWin) in
            guard let self else {return}
            self.firstWinLabel.text = "1등: \(firstWin)원"
        }
    }

}
