import Foundation

struct Fourteen {
    private struct Position: Hashable {
        let x: Int
        let y: Int

        func directed(to: Direction) -> Self {
            switch to {
            case .leftdown: return Position(x: x - 1, y: y + 1)
            case .rightdown: return Position(x: x + 1, y: y + 1)
            case .down: return Position(x: x, y: y + 1)
            }
        }
    }

    private enum Direction {
        case down, leftdown, rightdown
    }

    func run(input: String) -> Int {
        let obstacles = Set(parsed(input: input))
        let emitter = Position(x: 500, y: 0)
        return countSands(obstacles: obstacles, emitter: emitter, floor: nil)
    }

    func runWithFloor(input: String) -> Int {
        let obstacles = parsed(input: input)
        let emitter = Position(x: 500, y: 0)
        let floor = obstacles.max { $0.y < $1.y }!.y + 2
        let allSands = countSands(obstacles: obstacles, emitter: emitter, floor: floor)//run3(obstacles: obstacles, emitter: emitter, floor: floor)
        return allSands + 1
    }

    private func countSands(obstacles: Set<Position>, emitter: Position, floor: Int?) -> Int {
        var sands = Set<Position>()
        var currentSand: Position?
        while true {
            let sand: Position = currentSand ?? emitter
            let nextPosition = [
                sand.directed(to: .down),
                sand.directed(to: .leftdown),
                sand.directed(to: .rightdown),
            ].filter { !obstacles.contains($0) && !sands.contains($0) }
                .first { (floor ?? Int.max) > $0.y }

            let willFallForever = floor == nil ? nextPosition
                .flatMap { next in obstacles.first { $0.x == next.x && $0.y > next.y } } == nil : false

            if let _ = nextPosition, willFallForever {
                break
            } else if let nextPosition {
                currentSand = nextPosition
            } else if sand == emitter {
                break
            } else {
                sands.insert(sand)
                currentSand = nil
            }
        }

        return sands.count
    }

    private func parsed(input: String) -> Set<Position> {
        let positions = input
            .split(separator: "\n")
            .map { parseRow(String($0)) }
        return Set(positions.flatMap { $0 })
    }

    private func parseRow(_ input: String) -> Set<Position> {
        let positions = input
            .replacingOccurrences(of: " -> ", with: "|")
            .split(separator: "|")
            .map { $0.split(separator: ",") }
            .map {
                assert($0.count == 2)
                return Position(x: Int("\($0.first!)")!, y: Int("\($0.last!)")!)
            }

        let all = zip(
            positions[0 ..< positions.count - 1],
            positions[1 ..< positions.count]
        )
        .flatMap { allPositions(start: $0, end: $1) }

        return Set(all)
    }

    private func allPositions(start: Position, end: Position) -> [Position] {
        let xRange = (min(start.x, end.x) ... max(start.x, end.x))
        let yRange = (min(start.y, end.y) ... max(start.y, end.y))

        return paddedZip(xRange, yRange).map { x, y in
            Position(x: x ?? max(start.x, end.x),
                     y: y ?? max(start.y, end.y))
        }
    }

    private func debugPrint(positions: Set<Position>, sand: Set<Position>) {
        let posMinY = positions.min { $0.y < $1.y }!.y
        let posMaxY = positions.max { $0.y < $1.y }!.y
        let posMinX = positions.min { $0.x < $1.x }!.x
        let posMaxX = positions.max { $0.x < $1.x }!.x
        let sandMinY = sand.min { $0.y < $1.y }?.y ?? posMinY
        let sandMaxY = sand.max { $0.y < $1.y }?.y ?? posMaxY
        let sandMinX = sand.min { $0.x < $1.x }?.x ?? posMinX
        let sandMaxX = sand.max { $0.x < $1.x }?.x ?? posMaxX

        let minX = min(posMinX, sandMinX)
        let maxX = max(posMaxX, sandMaxX)
        let minY = min(posMinY, sandMinY)
        let maxY = max(posMaxY, sandMaxY)

        let printable =
            (minY ... maxY).map { y in
                (minX ... maxX).map { x in
                    if sand.contains(Position(x: x, y: y)) {
                        return "o"
                    }
                    return positions.contains(Position(x: x, y: y)) ? "#" : "."
                }.joined()
            }.joined(separator: "\n")

        print(printable)
    }
}
