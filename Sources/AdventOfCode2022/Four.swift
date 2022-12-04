import Foundation

struct Four {
    func numberOfCoveredPairs(in input: String) -> Int {
        parsed(input: input)
            .filter { $0.0.isCovered(by: $0.1) || $0.1.isCovered(by: $0.0) }
            .count
    }

    func numberOfOverlappingPairs(in input: String) -> Int {
        parsed(input: input)
            .filter { $0.0.hasOverlap(with: $0.1) || $0.1.hasOverlap(with: $0.0) }
            .count
    }

    private func parsed(input: String) -> [(ClosedRange<Int>, ClosedRange<Int>)] {
        input
            .split(separator: "\n")
            .map { parsedPair(input: String($0)) }
    }

    private func parsedPair(input: String) -> (ClosedRange<Int>, ClosedRange<Int>) {
        let pair = input
            .split(separator: ",")
            .map { parsedRange(input: String($0)) }

        assert(pair.count == 2)
        return (pair.first!, pair.last!)
    }

    private func parsedRange(input: String) -> ClosedRange<Int> {
        let range = input
            .split(separator: "-")
            .map { String($0) }
            .map { Int($0)! }

        assert(range.count == 2)
        return range.first! ... range.last!
    }
}
