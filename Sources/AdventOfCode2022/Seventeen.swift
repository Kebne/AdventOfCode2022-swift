import Accelerate
import Foundation

struct Seventeen {
    enum Movement: String {
        case left = "<"
        case right = ">"
        case down
    }

    enum RockType: Hashable {
        // ####
        case one
        // .#.
        // ###
        // .#.
        case two
        // ..#
        // ..#
        // ###
        case tree
        // #
        // #
        // #
        // #
        case four
        // ##
        // ##
        case five

        var mask: [[Int]] {
            switch self {
            case .one:
                return [[1, 1, 1, 1]]
            case .two:
                return [
                    [0, 1, 0],
                    [1, 1, 1],
                    [0, 1, 0],
                ]

            case .tree:
                return [
                    [0, 0, 1],
                    [0, 0, 1],
                    [1, 1, 1],
                ]
            case .four:
                return [
                    [1],
                    [1],
                    [1],
                    [1],
                ]

            case .five:
                return [
                    [1, 1],
                    [1, 1],
                ]
            }
        }
    }

    struct Position: Hashable {
        let x: Int
        let y: Int

        func applied(_ move: Movement) -> Self {
            switch move {
            case .left: return Position(x: x - 1, y: y)
            case .right: return Position(x: x + 1, y: y)
            case .down: return Position(x: x, y: y + 1)
            }
        }
    }

    struct Rock: Hashable {
        let type: RockType
        let position: Position

        func applied(_ move: Movement, in map: Map) -> Self {
            if position.x <= 0, move == .left {
                return self
            }

            if position.x >= map[0].count - 1, move == .right {
                return self
            }

            let nextPosition = position.applied(move)
            let mask = type.mask

            if nextPosition.x + mask[0].count > map[0].count {
                return self
            }

            if nextPosition.y + mask.count > map.count {
                return self
            }

            for y in nextPosition.y ..< nextPosition.y + mask.count {
                for x in nextPosition.x ..< nextPosition.x + mask[0].count {
                    if map[y][x] + mask[y - nextPosition.y][x - nextPosition.x] == 2 {
                        return self
                    }
                }
            }

            return Rock(type: type, position: nextPosition)
        }
    }

    func parsedStream(input: String) -> [Movement] {
        return input.map { Movement(rawValue: "\($0)")! }
    }

    func run(with input: String, rocks: Int) -> Int {
        let stream = parsedStream(input: input)
        let movements = zip(stream, Array(repeating: Movement.down, count: stream.count)).flatMap { [$0, $1] }
        let rockTypes = [RockType.one, .two, .tree, .four, .five]
        let row: [Int] = Array(repeating: 0, count: 7)

        var turn = 0
        var map = Array(repeating: row, count: 4)
        for i in 0..<rocks {
            let (newTurn, newMap) = simulate(rock: rockTypes[i % rockTypes.count], map: map, movements: movements, turn: turn)
            turn = newTurn
            map = newMap
        }

        return map.filter { $0.reduce(0, +) > 0 }.count
    }

    typealias Map = [[Int]]
    func simulate(rock rockType: RockType, map: Map, movements: [Movement], turn: Int) -> (turn: Int, map: Map) {
        var map = map
        var turn = turn
        var y = (map.enumerated().first { $0.element.contains(1) }?.offset ?? map.count) - rockType.mask.count - 3
        let x = 2

        if y < 0 {
            let row: [Int] = Array(repeating: 0, count: 7)
            let extend = Array(repeating: row, count: abs(y))
            map = extend + map
            y = 0
        }

        let position = Position(x: x, y: y)
        var rock = Rock(type: rockType, position: position)

        while true {
            let nextMove = movements[turn % movements.count]
            let nextRock = rock.applied(nextMove, in: map)

            turn += 1

            if nextMove == .down && rock == nextRock {
                break
            } else {
                rock = nextRock
            }
        }

        for y in rock.position.y ..< rock.position.y + rockType.mask.count {
            for x in rock.position.x ..< rock.position.x + rockType.mask[0].count {
                map[y][x] += rock.type.mask[y - rock.position.y][x - rock.position.x]
            }
        }

       // printMap(map)

        return (turn, map)
    }

    func printMap(_ map: Map) {
        let printable = map.map {
            $0.map { $0 == 0 ? "." : "#" }.joined()
        }.joined(separator: "\n")
        print(printable)
    }
}
