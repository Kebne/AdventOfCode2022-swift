import Accelerate
import Foundation

class Seventeen {
    enum Movement: String {
        case left = "<"
        case right = ">"
        case down
    }

    enum RockType: Hashable {
        case one
        case two
        case tree
        case four
        case five

        var width: Int {
            switch self {
            case .one: return 4
            case .two: return 3
            case .tree: return 3
            case .four: return 1
            case .five: return 2
            }
        }

        var height: Int {
            switch self {
            case .one: return 4
            case .two: return 3
            case .tree: return 3
            case .four: return 1
            case .five: return 2
            }
        }

        func position(relative start: Position) -> [Position] {
            switch self {
            case .one:
                return [start.with(dx: 0), start.with(dx: 1), start.with(dx: 2), start.with(dx: 3)]
            case .two:
                return [
                    start.with(dx: 1),
                    start.with(dx: 0, dy: 1), start.with(dx: 1, dy: 1), start.with(dx: 2, dy: 1),
                    start.with(dx: 1, dy: 2),
                ]
            case .tree:
                return [
                    start.with(dx: 2, dy: 2),
                    start.with(dx: 2, dy: 1),
                    start.with(dx: 0, dy: 0), start.with(dx: 1, dy: 0), start.with(dx: 2, dy: 0),
                ]
            case .four:
                return [
                    start.with(dx: 0),
                    start.with(dx: 0, dy: 1),
                    start.with(dx: 0, dy: 2),
                    start.with(dx: 0, dy: 3),
                ]
            case .five:
                return [
                    start.with(dx: 0), start.with(dx: 1, dy: 0),
                    start.with(dx: 0, dy: 1), start.with(dx: 1, dy: 1),
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
            case .down: return Position(x: x, y: y - 1)
            }
        }

        func with(dx: Int? = nil, dy: Int? = nil) -> Self {
            Position(x: x + (dx ?? 0), y: y + (dy ?? 0))
        }
    }

    struct Rock: Hashable {
        let type: RockType
        let position: Position

        func applied(_ move: Movement, in map: Map) -> (Self, [Position]?) {

            if position.x <= 0, move == .left {
                return (self, nil)
            }

            if position.x + type.width > 6, move == .right {
                return (self, nil)
            }

            if position.y <= 0, move == .down {
                return (self, nil)
            }

            let nextPosition = position.applied(move)
            let allPositions = type.position(relative: nextPosition)

            if map.intersection(allPositions).count > 0 {
                return (self, nil)
            }

            return (Rock(type: type, position: nextPosition), allPositions)
        }
    }

    func parsedStream(input: String) -> [Movement] {
        return input.map { Movement(rawValue: "\($0)")! }
    }

    func run(with input: String, rocks: Int) -> Int {
        let stream = parsedStream(input: input)
        let movements = zip(stream, Array(repeating: Movement.down, count: stream.count)).flatMap { [$0, $1] }
        let rockTypes = [RockType.one, .two, .tree, .four, .five]

        var turn = 0
        var height = 0
        var map: Set<Position> = []
        for rock in 0 ..< rocks {

            let rockType = rockTypes[rock % rockTypes.count]
            let (nextTurn, nextMap, tallness) = simulate(rock: rockType, map: map, movements: movements, turn: turn)
            height = tallness
            map = nextMap
            turn = nextTurn

            var cacheKey: CacheKey?
            if let silhouette = self.silhouette(from: map, width: 7) {
                let key = CacheKey(movementIndex: turn % movements.count, rockType: rockType, silhouette: silhouette)
                if let hit = cache[key] {

                    let heightThen = hit.height
                    let heightNow = height
                    let seqHeight = heightNow - heightThen
                    let seqLength = rock - hit.rock
                    let multiplier = (rocks - hit.rock) / seqLength
                    let rocksLeft = (rocks - hit.rock) % seqLength
                    let heightGain = (multiplier - 1) * (seqHeight)
                    height -= 1

                    for i in (0..<rocksLeft) {
                        let rockType = rockTypes[(rock + i + 1) % rockTypes.count]
                        let (nextTurn, nextMap, tallness) = simulate(rock: rockType, map: map, movements: movements, turn: turn)
                        map = nextMap
                        turn = nextTurn
                        height = tallness
                    }
                    return height + heightGain
                }
                cacheKey = key
            }

            if let cacheKey {
                cache[cacheKey] = (height: height, rock)
            }

        }

        return height + 1
    }

    struct CacheKey: Hashable {
        let movementIndex: Int
        let rockType: RockType
        let silhouette: [Position]
    }

    var cache: [CacheKey: (height: Int, rock: Int)] = [:]
    typealias Map = Set<Position>
    func simulate(rock rockType: RockType, map: Map, movements: [Movement], turn: Int) -> (turn: Int, nextMap: Map, tallness: Int) {
        var turn = turn
        let y = (map.min { $0.y > $1.y }?.y ?? -1) + 4
        let x = 2

        let position = Position(x: x, y: y)
        var rock = Rock(type: rockType, position: position)
        var endPosition: [Position] = []

        while true {
            let nextMove = movements[turn % movements.count]
            let next = rock.applied(nextMove, in: map)
            turn += 1

            if nextMove == .down, next.1 == nil {
                break
            } else if let pos = next.1 {
                endPosition = pos
                rock = next.0
            }
        }


        let nextMap = map.union(endPosition)
        let tallness = nextMap.max { $0.y < $1.y }!.y

        return (turn, nextMap, tallness)
    }

    func silhouette(from map: Map, width: Int) -> [Position]? {
        let silhouette = (0..<width).compactMap { x in
            map.filter({ $0.x == x }).max(by: { $0.y < $1.y })
        }

        guard silhouette.count  == width else {
            return nil
        }

        let minY = silhouette.min { $0.y < $1.y }!.y
        return silhouette.map { Position(x: $0.x, y: $0.y - minY) }
    }

    func printMap(_ map: Map) {

        let maxY = map.max { $0.y < $1.y }!.y
        let printable = (0...maxY).reversed().map { y in
            (0..<7).map { x in
                map.contains(Position(x: x, y: y)) ? "#" : "."
            }.joined()
        }.joined(separator: "\n")
        print(printable)
    }
}
