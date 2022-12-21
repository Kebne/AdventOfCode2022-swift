import Algorithms
import Foundation

struct Eighteen {
    typealias Side = Set<Point>
    typealias Size = (x: Int, y: Int, z: Int)

    class Cube {
        let points: [Point]
        var waterMap: [Point: Bool]
        let minX, minY, minZ: Int
        let maxX, maxY, maxZ: Int

        init(_ points: [Point]) {
            minX = points.min { $0.x < $1.x }!.x - 1
            maxX = points.max { $0.x < $1.x }!.x + 1
            minY = points.min { $0.y < $1.y }!.y - 1
            maxY = points.max { $0.y < $1.y }!.y + 1
            minZ = points.min { $0.z < $1.z }!.z - 1
            maxZ = points.max { $0.z < $1.z }!.z + 1
            self.points = points
            waterMap = Dictionary(uniqueKeysWithValues: zip(points, Array(repeating: false, count: points.count)))
        }

        func contains(_ point: Point) -> Bool {
            point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY && point.z >= minZ && point.z <= maxZ
        }
    }

    struct Point: Hashable, CustomStringConvertible {
        var description: String { "\(x)\(y)\(z)" }

        let x: Int
        let y: Int
        let z: Int

        func sidessForCube(of size: Size) -> Set<Side> {
            let xValues = [x, x + size.x]
            let yValues = [y, y + size.y]
            let zValues = [z, z + size.z]
            let side1 = xValues.flatMap { x in yValues.map { y in Point(x: x, y: y, z: z) } }
            let side2 = side1.map { Point(x: $0.x, y: $0.y, z: $0.z + size.z) }
            let side3 = xValues.flatMap { x in zValues.map { z in Point(x: x, y: y, z: z) } }
            let side4 = side3.map { Point(x: $0.x, y: $0.y + size.y, z: $0.z) }
            let side5 = yValues.flatMap { y in zValues.map { z in Point(x: x, y: y, z: z) }}
            let side6 = side5.map { Point(x: $0.x + size.x, y: $0.y, z: $0.z) }
            return Set([side1, side2, side3, side4, side5, side6].map { Set($0) })
        }

        var neighbours: [Point] {
            [
                Point(x: x - 1, y: y, z: z),
                Point(x: x + 1, y: y, z: z),
                Point(x: x, y: y - 1, z: z),
                Point(x: x, y: y + 1, z: z),
                Point(x: x, y: y, z: z - 1),
                Point(x: x, y: y, z: z + 1),
            ]
        }
    }

    func surfaceArea(in input: String) -> Int {
        let sides = parsed(input: input).map { $0.sidessForCube(of: (1, 1, 1)) }

        var uniqueSides: Set<Side> = []

        for side in sides {
            uniqueSides = side.symmetricDifference(uniqueSides)
        }

        return uniqueSides.count
    }

    func surfaceAreaAfterWater(input: String) -> Int {
        let points = parsed(input: input)
        let cube = Cube(points)
        let start = Point(x: cube.minX, y: cube.minY, z: cube.minZ)
        pourWater(into: cube, from: start)

        let result = cube
            .waterMap
            .filter { $0.value }
            .map { $0.key }
            .map { $0.neighbours.filter { !(cube.waterMap[$0] ?? true) }.count }

        return result.reduce(0, +)
    }

    private func parsed(input: String) -> [Point] {
        input.split(separator: "\n").map {
            let coordinates = $0.split(separator: ",").map { Int($0.trimmingCharacters(in: .whitespaces))! }
            assert(coordinates.count == 3)
            return Point(x: coordinates[0], y: coordinates[1], z: coordinates[2])
        }
    }

    private func pourWater(into cube: Cube, from start: Point) {
        cube.waterMap[start] = true

        let emptyNeighbours = start
            .neighbours
            .filter { cube.contains($0) }
            .filter { cube.waterMap[$0] == nil }

        for neighbour in emptyNeighbours {
            pourWater(into: cube, from: neighbour)
        }
    }
}
