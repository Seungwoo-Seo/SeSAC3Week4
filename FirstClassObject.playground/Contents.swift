import UIKit

func welcome() {
    print("안녕하세요 반값습니다")
}

func welcome(name: String) {
    print("안녕하세요 \(name)님, 반갑습니다")
}

func welcome(name: String) -> String {
    return "안녕하세요 \(name)님, 반갑습니다"
}

func welcome() -> String {
    return "안녕하세요 반값습니다"
}

func introduce(message: (String) -> ()) {

}
/*
 변수/상수나 데이터 구조 내에 자료형을 저장할 수 있다
 함수의 반환값으로 자료형을 사용할 수 있다
 함수의 인자값으로 자료형을 전달할 수 있다
 */


introduce


func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "신한", "국민"]

    return bankArray.contains(bank) ? true : false
}

let result = checkBankInformation(bank: "농협")

// 변수나 상수에 함수 그 '자체'를 대입할 수 있다 (1급 객체의 특성)
// 함수만 대입한 것으로, 함수가 실행된 상태는 아님

// (String) -> Bool : Function Type (ex. Tuple)
let checkAccount: (String) -> Bool = checkBankInformation

// 함수를 호출하면 실행할 수 있음
checkAccount("카뱅")

let tupleExample = (1, 2, 33, "Hello", true)


func hello(username: String) -> String {
    return "저는 \(username)입니다"
}

func hello(username: String, age: Int) -> String {
    return "저는 \(username), \(age)살 입니다"
}

func hello(nickname: String) -> String {
    return "저는 \(nickname)입니다"
}

// 오버로딩 특성으로 함수를 구분하기 힘들 때, 타입 어노테이션을 통해서 함수를 구별할 수 있다
// 하지만 타입 어노테이션만으로 함수를 구별할 수 없는 상황도 있다..
// 함수 표기법을 사용한다면 타입어노테이션을 생략하더라도 함수를 구별할 수 있다!
let example: (String) -> String = hello(nickname:)
// 파라미터 생략 가능?
example("고래밥")

// 2. 함수의 반환 타입으로 함수를 사용할 수 잇다.
func currentAccount() -> String {
    return "계좌 있다는 얼럿 띄우기"
}

func noCurrentAccount() -> String {
    return "계좌 없으니 게좌 생성 화면으로 이동"
}

//func checkBankInformation(bank: String) -> Bool {
//    let bankArray = ["우리", "신한", "국민"]
//
//    return bankArray.contains(bank) ? true : false
//}

// rㅏ장 왼쪽에 위치한 -> 를 기준으로, 오른쪽에 놓인 모든 타입은 반환값을 의미한다.
func checkBank(bank: String) -> () -> String {
    let bankArray = ["우리", "신한", "국민"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount
}

let jack = checkBank(bank: "신한")
jack()

checkBank(bank: "신한")()

func plus(a: Int, b: Int) -> Int {
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    switch operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
    }
}

calculate(operand: "+") // 함수가 실행되고 있는 상태가 아님

let resultCalculate = calculate(operand: "*")
resultCalculate(5, 9)


// 3. 함수의 인자값으로 함수를 사용할 수 잇따.
func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

func setNavigationBar() {

}

func setLabel() {
}

func resultNumber(number: Int, odd: () -> Void, even: () -> Void) {
    return number.isMultiple(of: 2) ? even() : odd()
}

resultNumber(number: 8, odd: oddNumber, even: evenNumber)

// 의도하지 않는 함수가 들어갈 위험이 있고, 필요 이상의 함수가 자꾸 생성될 수 잇음
// -> 그래서 이름 없는 함수를 사용하게 됨
resultNumber(number: 29, odd: setLabel, even: setNavigationBar)

resultNumber(
    number: 29,
    odd: {},
    even: {}
)

resultNumber(number: 0, odd: {}) {
    <#code#>
}
