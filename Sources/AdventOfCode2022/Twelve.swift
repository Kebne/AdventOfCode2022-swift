import Foundation

struct Twelve {
    private typealias Map = [[Character]]
    private typealias StartPosition = (position: Position, distance: Int)
    private struct Position: Hashable {
        let x: Int
        let y: Int

        func directed(to: Direction) -> Self {
            switch to {
            case .up: return Position(x: x, y: y + 1)
            case .right: return Position(x: x + 1, y: y)
            case .down: return Position(x: x, y: y - 1)
            case .left: return Position(x: x - 1, y: y)
            }
        }
    }

    private enum Direction {
        case up, right, down, left
    }

    private let letters = ("a" ... "z").characters

    func shortestPathFromS(input: String) -> Int {
        let map = parsed(input: input)
        let start = positionOf("S", in: map)
        return shortestRoute(start: start, end: "E", in: map, isAllowedStep: atMostOneStepHigher)
    }

    func shortestPathFromAnyA(input: String) -> Int {
        let map = parsed(input: input) { $0 == "S" ? "a" : $0 }
        let start = positionOf("E", in: map)
        return shortestRoute(start: start, end: "a", in: map, isAllowedStep: atMostOneStepLower)
    }

    private func parsed(input: String, replacer: ((Character) -> Character)? = nil) -> Map {
        input
            .split(separator: "\n")
            .map { $0.map { replacer?($0) ?? $0 } }
    }

    private func shortestRoute(start: Position, end: Character, in map: Map, isAllowedStep: (Character?, Character) -> Bool) -> Int {
        var startPositions: [StartPosition] = [(position: start, distance: 0)]
        var visited: [Position] = []

        while !startPositions.isEmpty {
            let current = startPositions.removeFirst()
            let position = current.position
            let distance = current.distance
            let value = map[position.y][position.x]

            if visited.contains(position) {
                continue
            }

            visited.append(position)

            if value == end {
                return distance
            }

            let nextPos: [Position] = [position.directed(to: .up),
                                       position.directed(to: .right),
                                       position.directed(to: .down),
                                       position.directed(to: .left)]
                .filter { $0.y >= 0 && $0.x >= 0 }
                .filter { $0.y < map.count && $0.x < map[$0.y].count }
                .filter { isAllowedStep(map[$0.y][$0.x], value) }

            let n2 = nextPos.map { (position: $0, distance: distance + 1) }
            startPositions.append(contentsOf: n2)
        }

        return -1
    }

    private func atMostOneStepHigher(_ target: Character?, from: Character) -> Bool {
        guard from != "S" else { return true }
        guard var target else { return false }

        if target == "E" {
            target = "z"
        }
        return from.asciiValue! + 1 >= target.asciiValue!
    }

    private func atMostOneStepLower(_ target: Character?, from: Character) -> Bool {
        guard var target else { return false }
        var from = from

        if from == "E" {
            from = "z"
        }

        if target == "S" {
            target = "a"
        }
        return from.asciiValue! <= target.asciiValue! + 1
    }

    private func positionOf(_ char: Character, in map: Map) -> Position {
        for (y, row) in map.enumerated() {
            for (x, value) in row.enumerated() {
                if value == char {
                    return Position(x: x, y: y)
                }
            }
        }

        fatalError()
    }
}
