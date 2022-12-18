import Foundation

class Sixteen {
    typealias Map = [Valve: [Valve: Int]]
    typealias Path = Set<Valve>
    struct Valve: Hashable {
        let name: String
        let rate: Int
        let next: [String]
    }

    func run(input: String) -> Int {
        let valves = parsed(input: input)
        let start = valves.first { $0.name == "AA" }!

        let map = distanceMap(valves: valves, start: start)
        let nonZeroValves = valves.filter { $0.rate > 0 }
        let paths = open(valve: start, valves: nonZeroValves, minutes: 30, distances: map, path: [])
        return paths.max { $0.value < $1.value }!.value
    }

    func runParallell(input: String) -> Int {
        let valves = parsed(input: input)
        let start = valves.first { $0.name == "AA" }!

        let map = distanceMap(valves: valves, start: start)
        let nonZeroValves = valves.filter { $0.rate > 0 }
        let paths = open(valve: start, valves: nonZeroValves, minutes: 26, distances: map, path: [])

        var bestCombination = 0
        for p1 in paths {
            for p2 in paths where p1 != p2 {
                if p1.key.intersection(p2.key).isEmpty {
                    bestCombination = max(p1.value + p2.value, bestCombination)
                }
            }
        }

        return bestCombination
    }

    func open(valve: Valve, valves: [Valve], minutes: Int, distances: Map, path: Path) -> [Path: Int] {
        let valves = valves.filter { $0 != valve }
        var paths: [Path: Int] = [path: 0]
        for next in valves {
            let minLeft = minutes - distances[valve]![next]! - 1
            if minLeft <= 0 {
                continue
            }

            open(valve: next, valves: valves, minutes: minLeft, distances: distances, path: path.union([next]))
                .mapValues { $0 + next.rate * minLeft }
                .forEach { paths[$0.key] = max(paths[$0.key] ?? 0, $0.value) }
        }

        return paths
    }

    private func parsed(input: String) -> [Valve] {
        return input
            .split(separator: "\n")
            .map { parsedValve(in: String($0)) }
    }

    private func distanceMap(valves: [Valve], start: Valve) -> Map {
        let nonZeroValves = Set(valves.filter { $0.rate > 0 }).union([start])
        var distanceMap: Map = [:]

        for valve in nonZeroValves {
            var queue = [valve]
            var distances = [valve: 0]
            var visited = Set(queue)

            while !queue.isEmpty {
                let current = queue.removeFirst()
                for next in current.next.map({ next in valves.first { $0.name == next }! }) {
                    if !visited.contains(next) {
                        visited.insert(next)
                        distances[next] = distances[current, default: 0] + 1
                        queue.append(next)
                    }
                }
            }

            distanceMap[valve] = distances
        }

        return distanceMap
    }

    private func parsedValve(in row: String) -> Valve {
        let pattern = #"Valve (?<name>[A-Z][A-Z]) has flow rate=(?<rate>\d*);[^A-Z]*(?<leads>([A-Z][A-Z],?\s?)+)"#
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(row.startIndex ..< row.endIndex, in: row)

        let matches = regex.matches(
            in: row,
            options: [],
            range: range
        )

        let match = matches.first!

        var captures: [String: String] = [:]

        for name in ["name", "rate", "leads"] {
            let matchRange = match.range(withName: name)
            // Extract the substring matching the named capture group
            if let substringRange = Range(matchRange, in: row) {
                let capture = String(row[substringRange])
                captures[name] = capture
            }
        }

        let name = captures["name"]!
        let rate = captures["rate"]!
        let next = captures["leads"]?.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }

        return Valve(name: name, rate: Int(rate)!, next: next ?? [])
    }
}
