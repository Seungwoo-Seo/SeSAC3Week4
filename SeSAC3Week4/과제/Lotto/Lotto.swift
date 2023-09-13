//
//  Lotto.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/09/13.
//

import Foundation

struct Lotto: Decodable {
    let drwNo: Int
    let drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6, bnusNo: Int
    let firstWinamnt: Int
}
