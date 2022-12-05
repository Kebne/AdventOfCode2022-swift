import Foundation

struct Five {
    typealias Movement = (amount: Int, from: Int, to: Int)
    typealias Stack = [String]

    func parsed(input: String) -> (placements: [Stack], movements: [Movement]) {
        let test = input.components(separatedBy: .newlines)
        let placements = parsedPlacements(in: test)
        let movements = parsedMovements(in: test)
        return (placements, movements)
    }

    func topOfStacks(input: String, canLiftMany: Bool) -> String {
        let parsedInput = parsed(input: input)
        var stacks = parsedInput.placements
        parsedInput.movements.forEach {
            stacks = apply($0, on: stacks, canLiftMany: canLiftMany)
        }
        return stacks.map { $0.first! }.joined()
    }

    func apply(_ move: Movement, on stacks: [Stack], canLiftMany: Bool) -> [Stack] {
        let source = stacks[move.from - 1]
        let target = stacks[move.to - 1]

        let toBeMoved: [String]
        if !canLiftMany {
            toBeMoved = Array(source.prefix(move.amount).reversed())
        } else {
            toBeMoved = Array(source.prefix(move.amount))
        }

        let newTarget = Array(toBeMoved + target)
        let newSource = Array(source.dropFirst(move.amount))

        return stacks.enumerated().map {
            if $0.offset + 1 == move.from {
                return newSource
            } else if $0.offset + 1 == move.to {
                return newTarget
            }
            return $0.element
        }
    }

    func parsedMovements(in input: [String]) -> [Movement] {
        input.filter { $0.starts(with: "move") }.map {
            parsedMovement(in: $0)
        }
    }

    func parsedMovement(in row: String) -> Movement {
        let move = row
            .replacingOccurrences(of: "move ", with: "")
            .replacingOccurrences(of: " from ", with: ",")
            .replacingOccurrences(of: " to ", with: ",")
            .split(separator: ",")
            .map { Int($0)! }

        return (move[0], move[1], move[2])
    }

    func parsedPlacements(in input: [String]) -> [[String]] {
        let placements = input
            .filter { $0.contains("[") }
            .map { parsedPlacement(in: $0) }

        let longest = placements
            .map { $0.count }
            .max()!

        return placements
            .map { $0.padded(to: longest, with: nil)! }
            .transposed()
            .map { $0.compactMap { $0 } }
    }

    func parsedPlacement(in row: String) -> [String?] {
        let pattern = #"(\[\w\]|\s\s\s)\s?"#
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(row.startIndex ..< row.endIndex, in: row)
        var matches: [String?] = []
        regex.enumerateMatches(in: row, options: [], range: range) { match, _, _ in
            let localRange = Range(match!.range(at: 0), in: row)
            let found = String(row[localRange!])
                .replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: " ", with: "")
            if !found.isEmpty {
                matches.append(found)
            } else {
                matches.append(nil)
            }
        }

        return matches
    }
}
