import Foundation

struct Two {
    enum Outcome: Int {
        case win = 6
        case draw = 3
        case loss = 0

        static func from(_ str: Substring) -> Self {
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

        static func from(_ str: Substring) -> Self {
            switch str {
            case "A": return .rock
            case "B": return .paper
            case "C": return .scissors
            case "Y": return .paper
            case "X": return .rock
            case "Z": return .scissors
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

    typealias Round = (Selection, Selection)
    typealias Round2 = (Selection, Outcome)

    func points(given strategy: String) -> Int {
        parsed(input: strategy)
            .map { points(for: $0) }
            .reduce(0, +)
    }

    func points2(given strategy: String) -> Int {
        parsed2(input: strategy)
            .map { points(for: $0) }
            .reduce(0, +)
    }

    private func parsed2(input: String) -> [Round2] {
        input
            .split(separator: "\n")
            .map { parsedRound2(input: $0) }
    }

    private func parsed(input: String) -> [Round] {
        input
            .split(separator: "\n")
            .map { parsedRound(input: $0) }
    }

    private func parsedRound2(input: Substring) -> Round2 {
        let splitted = input.split(separator: " ")
        assert(splitted.count == 2)

        return (Selection.from(splitted.first!), Outcome.from(splitted.last!))
    }

    private func parsedRound(input: String.SubSequence) -> Round {
        let selections = input.split(separator: " ").map {
            Selection.from($0)
        }

        assert(selections.count == 2)
        return (selections.first!, selections.last!)
    }

    private func points(for round: Round2) -> Int {
        let selection = round.0.selection(toAchieve: round.1)
        return selection.rawValue + round.1.rawValue
    }

    private func points(for round: Round) -> Int {
        let outcome = outcome(for: round)
        return outcome.rawValue + round.1.rawValue
    }

    private func outcome(for round: Round) -> Outcome {
        switch (round.1, round.0) {
        case (.paper, .scissors): return .loss
        case (.paper, .rock): return .win
        case (.scissors, .paper): return .win
        case (.scissors, .rock): return .loss
        case (.rock, .scissors): return .win
        case (.rock, .paper): return .loss
        case (.rock, .rock): return .draw
        case (.scissors, .scissors): return .draw
        case (.paper, .paper): return .draw
        }
    }
}
