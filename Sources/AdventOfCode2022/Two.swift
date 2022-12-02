import Foundation

struct Two {
    enum Outcome: Int {
        case win = 6
        case draw = 3
        case loss = 0

        static func from(_ str: String) -> Self {
            switch str {
            case "Y": return .draw
            case "X": return .loss
            case "Z": return .win
            default:
                fatalError()
            }
        }
    }

    enum Selection: Int {
        case rock = 1
        case paper = 2
        case scissors = 3

        static func from(_ str: String) -> Self {
            switch str {
            case "A": return .rock
            case "B": return .paper
            case "C": return .scissors
            default:
                fatalError()
            }
        }

        func outcome(against other: Selection) -> Outcome {
            switch mod((self.rawValue - other.rawValue), 3) {
            case 0: return .draw
            case 1: return .win
            case 2: return .loss
            default:
                fatalError()
            }
        }

        func selection(toAchieve outcome: Outcome) -> Selection {
            switch (outcome, self) {
            case (.win, .rock): return .paper
            case (.loss, .rock): return .scissors
            case (.win, .scissors): return .rock
            case (.loss, .scissors): return .paper
            case (.win, .paper): return .scissors
            case (.loss, .paper): return .rock
            case (.draw, _): return self
            }
        }
    }

    func runFirst(input: String) -> Int {
        let parsed = parsed(input: input)
        assert(parsed.count == 2)

        let mapping = ["X": "A", "Y": "B", "Z": "C"]
        return zip(parsed.first!, parsed.last!)
            .map {
                let me = Selection.from(mapping[$0.1] ?? $0.1)
                let opponent = Selection.from($0.0)
                let outcome = me.outcome(against: opponent)

                return me.rawValue + outcome.rawValue
            }.reduce(0, +)
    }

    func runSecond(input: String) -> Int {
        let parsed = parsed(input: input)
        assert(parsed.count == 2)

        return zip(parsed.first!, parsed.last!)
            .map {
                let opponent = Selection.from($0.0)
                let outcome = Outcome.from($0.1)
                let me = opponent.selection(toAchieve: outcome)

                return me.rawValue + outcome.rawValue
            }.reduce(0, +)
    }

    private func parsed(input: String) -> [[String]] {
        input
            .split(separator: "\n")
            .map {
                $0.split(separator: " ")
                    .map { String($0) }
            }
            .transposed()
    }
}
