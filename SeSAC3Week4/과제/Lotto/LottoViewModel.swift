//
//  LottoViewModel.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/09/13.
//

import Foundation

final class LottoViewModel {
    let turn = Observable(0)
    let number1 = Observable(0)
    let number2 = Observable(0)
    let number3 = Observable(0)
    let number4 = Observable(0)
    let number5 = Observable(0)
    let number6 = Observable(0)
    let bnus = Observable(0)
    let firstWin = Observable("")

    private let turnList: [Int] = Array(1...1079).reversed()

    var numberOfComponents: Int {
        return 1
    }

    var numberOfRowsInComponent: Int {
        return turnList.count
    }

    func titleForRow(_ row: Int) -> String {
        return "\(turnList[row])"
    }

}

// MARK: - 비즈니스
extension LottoViewModel {

    // 네트워크 작업을 완료하고 최종 가공된 데이터를
    // 할당해주는 작업이니까 네트워크 보단 비즈니스에 해당하는게 맞지
    func fetchToLotto(row: Int = 0) {
        let turn = turnList[row]
        LottoAPI.shared.request(turn: turn) { [weak self] lotto in
            guard let self else {return}
            self.turn.value = lotto.drwNo
            self.number1.value = lotto.drwtNo1
            self.number2.value = lotto.drwtNo2
            self.number3.value = lotto.drwtNo3
            self.number4.value = lotto.drwtNo4
            self.number5.value = lotto.drwtNo5
            self.number6.value = lotto.drwtNo6
            self.bnus.value = lotto.bnusNo
            self.firstWin.value = self.format(for: lotto.firstWinamnt)
        }
    }

    func format(for number: Int) -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format.string(for: number) ?? "???"
    }

}
