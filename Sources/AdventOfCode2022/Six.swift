import Foundation

struct Six {
    func firstMarker(in input: String, length: Int) -> Int {
        let inputChar = input.map { $0 }
        var start = 0
        while next(in: Array(inputChar.suffix(from: start)), of: length) == false {
            start += 1
        }

        return start + length
    }

    func next(in input: [Character], of length: Int) -> Bool {
        Set(input[0 ..< length]).count == length
    }
}
