import Foundation

struct Nine {
    struct Position: Hashable {
        let x: Int
        let y: Int

        func moved(in dir: Direction) -> Position {
            switch dir {
            case .up: return Position(x: x, y: y + 1)
            case .right: return Position(x: x + 1, y: y)
            case .down: return Position(x: x, y: y - 1)
            case .left: return Position(x: x - 1, y: y)
            }
        }
    }

    enum Direction: String {
        case up = "U"
        case right = "R"
        case down = "D"
        case left = "L"
    }

    func simulate(motions: String) -> Int {
        let directions = parsed(input: motions)
        var head = Position(x: 0, y: 0)
        var tail = Position(x: 0, y: 0)
        var tailPositions: [Position] = [tail]

        for direction in directions {
            let result = apply(direction, head: head, tail: tail)
            head = result.head
            tail = result.tail
            tailPositions.append(tail)
        }

        return Set(tailPositions).count
    }

    func simulateMany(motions: String) -> Int {
        let directions = parsed(input: motions)
        var knots = Array(repeating: Position(x: 0, y: 0), count: 10)
        var positions: [Position] = []

        for direction in directions {
            for (index, knot) in knots.enumerated() {
                if index == 0 {
                    knots[0] = knot.moved(in: direction)
                } else {
                    var movingKnot = knots[index]
                    movesFor(tail: movingKnot, relativeTo: knots[index - 1])
                        .forEach { movingKnot = movingKnot.moved(in: $0) }
                    knots[index] = movingKnot
                }
            }

            positions += [knots.last!]
        }

        return Set(positions).count
    }

    private func parsed(input: String) -> [Direction] {
        input
            .split(separator: "\n")
            .map { $0.split(separator: " ") }
            .flatMap {
                let steps = Int($0.dropFirst().joined())!
                let dir = Direction(rawValue: String($0.first!))!
                return Array(repeating: dir, count: steps)
            }
    }

    private func apply(_ dir: Direction, head: Position, tail: Position) -> (head: Position, tail: Position) {
        let newHead = head.moved(in: dir)
        var newTail = tail

        movesFor(tail: tail, relativeTo: newHead).forEach {
            newTail = newTail.moved(in: $0)
        }

        return (newHead, newTail)
    }

    private func movesFor(tail: Position, relativeTo head: Position) -> [Direction] {
        var directions: [Direction] = []

        if abs(tail.x - head.x) > 1 {
            directions += tail.x > head.x ? [Direction.left] : [Direction.right]

            if (tail.y - head.y) > 0 {
                directions += [Direction.down]
            } else if (head.y - tail.y) > 0 {
                directions += [Direction.up]
            }

            return directions
        }

        if abs(tail.y - head.y) > 1 {
            directions += tail.y > head.y ? [Direction.down] : [Direction.up]

            if (tail.x - head.x) > 0 {
                directions += [Direction.left]
            } else if (tail.x - head.x) < 0 {
                directions += [Direction.right]
            }

            return directions
        }

        return directions
    }
}
