import Foundation

struct One {
    private func parseBags(input: String) -> [[Int]] {
        input
            .components(separatedBy: .newlines)
            .map { Int($0) ?? -1 }
            .split { $0 == -1 }
            .compactMap { Array($0) }
    }

    private func bagSums(in input: String) -> [Int] {
        parseBags(input: input)
            .map { $0.reduce(0, +) }
    }

    func biggestBag(in input: String) -> Int {
        bagSums(in: input)
            .max()!
    }

    func sumOfTopTree(in input: String) -> Int {
        bagSums(in: input)
            .sorted { $0 > $1 }
            .prefix(3)
            .reduce(0, +)
    }
}
