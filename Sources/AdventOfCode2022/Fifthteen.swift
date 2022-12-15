import Foundation

struct Fifthteen {
    struct Scanner: Hashable {
        let position: Position
        let beacon: Position
        var manhattanDistance: Int { abs(position.x - beacon.x) + abs(position.y - beacon.y) }

        func xRange(for y: Int) -> Set<Int> {
            let diff = manhattanDistance - abs(position.y - y)

            if diff < 0 {
                return []
            }

            let x1 = position.x - diff
            let x2 = position.x + diff
            return Set(min(x1, x2) ... max(x1, x2))
        }


        func impossible(at pos: Position) -> Bool {
            guard position != pos, beacon != pos else { return true }

            let otherManhattan = abs(position.x - pos.x) + abs(position.y - pos.y)
            return manhattanDistance >= otherManhattan
        }

        func outsideOfBorder(lowerBound: Int, upperBound: Int) -> Set<Position> {
            let y1 = position.y - manhattanDistance
            let y2 = position.y + manhattanDistance
            let x1 = position.x - manhattanDistance
            let x2 = position.x + manhattanDistance

            let top = Position(x: position.x, y: min(y1, y2) - 1)
            let bottom = Position(x: position.x, y: max(y1, y2) + 1)
            let left = Position(x: min(x1, x2) - 1, y: position.y)
            let right = Position(x: max(x1, x2) + 1, y: position.y)

            let extremities = [top, right, bottom, left]

            let border = zip(extremities, extremities.dropFirst()).flatMap {
                $0.0.positions(to: $0.1).filter {
                    $0.x >= lowerBound && $0.x <= upperBound && $0.y >= lowerBound && $0.y <= upperBound
                }
            }

            return Set(border)
        }
    }

    struct Position: Hashable {
        let x: Int
        let y: Int

        func positions(to other: Position) -> [Position] {
            let dx = (other.x - x).signum()
            let dy = (other.y - y).signum()
            let diff = abs(x - other.x)

            return (0...diff).map { Position(x:x + dx * $0, y: y + dy * $0) }
        }
    }

    func findBeacon(in input: String, lower: Int, upper: Int) -> Int {
        let scanners = parsed(input: input)
        var possiblePositions: Set<Position> = []
        scanners.forEach {
            let possibleForScanner = $0.outsideOfBorder(lowerBound: lower, upperBound: upper)
            possiblePositions = possiblePositions.union(possibleForScanner)
        }

        for position in possiblePositions {
            if scanners.filter({ $0.impossible(at: position) }).isEmpty {
                return position.x * 4_000_000 + position.y
            }
        }
        fatalError()
    }

    func countImpossibles(in input: String, at row: Int) -> Int {
        let positions = parsed(input: input)

        let beaconsOnRow = Set(positions.map(\.beacon).filter { $0.y == row }.map { $0.x })
        let scannersOnRow = Set(positions.filter { $0.position.y == row }.map { $0.position.x })
        var xValues: Set<Int> = []

        positions.forEach {
            xValues = xValues.union($0.xRange(for: row))
        }

        return xValues.subtracting(beaconsOnRow).subtracting(scannersOnRow).count
    }

    func parsed(input: String) -> [Scanner] {
        return input.split(separator: "\n")
            .map { parseRow($0) }
    }

    func parseRow(_ input: Substring) -> Scanner {
        let splitted = input.split(separator: ":")
        let first = parseCoordinate(splitted.first!.replacingOccurrences(of: "Sensor at ", with: ""))
        let second = parseCoordinate(splitted.last!.replacingOccurrences(of: " closest beacon is at ", with: ""))

        let beacon = Position(x: second.x, y: second.y)
        let position = Position(x: first.x, y: first.y)
        return Scanner(position: position, beacon: beacon)
    }

    func parseCoordinate(_ input: String) -> (x: Int, y: Int) {
        let splitted = input.split(separator: ",")
        let x = splitted.first!.replacingOccurrences(of: "x=", with: "").trimmingCharacters(in: .whitespaces)
        let y = splitted.last!.replacingOccurrences(of: "y=", with: "").trimmingCharacters(in: .whitespaces)

        return (Int(x)!, Int(y)!)
    }

}
