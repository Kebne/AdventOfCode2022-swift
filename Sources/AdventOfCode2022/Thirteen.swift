import Foundation

struct Thirteen {
    private enum OrderResult {
        case ordered
        case unordered
        case undecided
    }

    private indirect enum Entry: Equatable {
        case list([Entry])
        case value(Int)

        func compare(to other: Entry) -> OrderResult {
            switch (self, other) {
            case let (.value(v1), .value(v2)):

                if v1 < v2 { return .ordered}
                else if v1 == v2 { return .undecided }
                else { return .unordered }

            case (.value, .list): return Entry.list([self]).compare(to: other)
            case let (.list, .value(value)): return compare(to: .list([Entry.value(value)]))
            case let (.list(l1), .list(l2)):

                for (v1, v2) in paddedZip(l1, l2) {
                    guard let v1, let v2 else { return v1 == nil ? .ordered : .unordered }
                    switch v1.compare(to: v2) {
                    case .unordered: return .unordered
                    case .ordered: return .ordered
                    case .undecided: continue
                    }
                }

                return .undecided
            }
        }
    }

    func sumOfCorrectIndices(in input: String) -> Int {
        let pairs = parsedEntries(input: input)
            .chunked(into: 2)

        let sum = pairs
            .enumerated()
            .compactMap {
                let first = $0.element.first!
                let second = $0.element.last!
                return first.compare(to: second) == .ordered ? $0.offset + 1 : nil
            }
            .reduce(0, +)

        return sum
    }

    func decoderKey(for input: String) -> Int {
        let dividers =
            """
            [[2]]
            [[6]]
            """

        let dividerEntries = parsedEntries(input: dividers)
        let entries = parsedEntries(input: input) + dividerEntries
        let sorted = entries.sorted { $0.compare(to: $1) == OrderResult.ordered }

        return sorted
            .enumerated()
            .filter { dividerEntries.contains($0.element) }
            .map { $0.offset + 1 }
            .reduce(1, *)
    }

    private func parsedEntries(input: String) -> [Entry] {
        input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { entry(from: $0) }
    }

    private func entry(from input: String) -> Entry {
        guard input.starts(with: "[") else {
            return .value(Int(input)!)
        }

        var input = input
        input.removeFirst()
        input.removeLast()

        let split = splitOnComma(input: input)
        let subEntries = split.map { entry(from: $0) }
        return .list(subEntries)
    }

    private func splitOnComma(input: String) -> [String] {
        var input = input
        var current: String?
        var level = 0
        var output: [String] = []

        while !input.isEmpty {
            let next = input.removeFirst()

            if next == "[" {
                level += 1
                current = (current ?? "") + String(next)
            } else if next == "]" {
                current = (current ?? "") + String(next)
                level -= 1
            } else if next != "," || level > 0 {
                current = (current ?? "") + String(next)
            }

            if next == ",", level == 0 {
                output.append(current!)
                current = nil
            }
        }

        if let current {
            output.append(current)
        }

        return output
    }
}
