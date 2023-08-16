//
//  UserDefaultsHelper.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/08/11.
//

import Foundation

final class UserDefaultsHelper {    // Property Wrapper
    private enum Key: String { // 컴파일 최적화
        case nickname, age
    }

    static let shared = UserDefaultsHelper() // 싱글턴 패턴

    let userDefaults = UserDefaults.standard

    var nickname: String {
        get {
            return userDefaults.string(
                forKey: Key.nickname.rawValue
            ) ?? "대장"
        }
        set {
            userDefaults.set(
                newValue,
                forKey: Key.nickname.rawValue
            )
        }
    }

    var age: Int {
        get {
            return userDefaults.integer(
                forKey: Key.age.rawValue
            )
        }
        set {
            userDefaults.set(
                newValue,
                forKey: Key.age.rawValue
            )
        }
    }

    private init() {}
}
