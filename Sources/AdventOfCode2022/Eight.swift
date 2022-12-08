import Foundation

struct Eight {
    typealias Position = (x: Int, y: Int)

    func highestScenicScore(in input: String) -> Int {
        let matrix = parsed(input: input)
        let all = (0 ..< matrix.count)
            .map { y in
                (0 ..< matrix[y].count)
                    .map { x in
                        Position(x: x, y: y)
                    }
            }
            .flatMap { $0 }

        return all.map { scenicScore($0, in: matrix) }.max()!
    }

    func howManyVisible(in input: String) -> Int {
        let matrix = parsed(input: input)
        let innerLayer = matrix.count / 2
        var count = 0

        for layer in (0 ... innerLayer).reversed() {
            let visible = visible(in: matrix, at: layer)
            count += visible
        }

        return count
    }

    private func isVisible(_ position: Position, in matrix: [[Int]]) -> Bool {
        let outlook = outlook(from: position, in: matrix)
        let value = matrix[position.y][position.x]
        let leftVisible = outlook.left.first { $0 >= value }
        let rightVisible = outlook.right.first { $0 >= value }
        let bottomVisible = outlook.bottom.first { $0 >= value }
        let topVisible = outlook.top.first { $0 >= value }
        let isVisible = leftVisible == nil || rightVisible == nil || topVisible == nil || bottomVisible == nil
        return isVisible
    }

    private func scenicScore(_ position: Position, in matrix: [[Int]]) -> Int {
        let outlook = outlook(from: position, in: matrix)
        let value = matrix[position.y][position.x]
        return [outlook.left.reversed(),
                outlook.right,
                outlook.bottom,
                outlook.top.reversed()]
            .map { treesUntilCovered(int: $0, value: value) }
            .reduce(1, *)
    }

    private func outlook(from position: Position,
                         in matrix: [[Int]]) -> (top: [Int], right: [Int], bottom: [Int], left: [Int]) {
        let xMax = matrix.count
        let yMax = matrix[0].count
        let left = Array(matrix[position.y][0 ..< max(0, position.x)])
        let right = Array(matrix[position.y][min(xMax, position.x + 1) ..< xMax])
        let bottom = Array(matrix[min(yMax, position.y + 1) ..< yMax].map { $0[position.x] })
        let top = Array(matrix[0 ..< position.y].map { $0[position.x] })

        return (top, right, bottom, left)
    }

    private func treesUntilCovered(int seq: [Int], value: Int) -> Int {
        var count = 0
        for i in seq {
            count += 1
            if value <= i {
                break
            }
        }

        return count
    }

    private func parsed(input: String) -> [[Int]] {
        input
            .split(separator: "\n")
            .map { $0.map { Int(String($0))! } }
    }

    private func visible(in matrix: [[Int]], at layer: Int) -> Int {
        let positions = positions(for: matrix, at: layer)
            .filter { isVisible($0, in: matrix) }

        return positions.count
    }

    private func positions(for matrix: [[Int]], at layer: Int) -> [Position] {
        guard matrix.count - layer * 2 > 1 else {
            return [(x: matrix.count - layer, y: matrix[layer].count - layer)]
        }

        let xTop = (layer ..< matrix[layer].count - layer).map {
            (x: $0, y: layer)
        }

        let xBottom = (layer ..< matrix[layer].count - layer).map {
            (x: $0, y: matrix.count - layer - 1)
        }

        let yLeft = (layer + 1 ..< matrix.count - layer - 1).map {
            (x: layer, y: $0)
        }

        let yRight = (layer + 1 ..< matrix.count - layer - 1).map {
            (x: matrix[layer].count - layer - 1, y: $0)
        }

        return xTop + xBottom + yLeft + yRight
    }
}
