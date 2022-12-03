import Foundation

struct Three {
    private var priorities: [Character: Int] = {
        let small = ("a" ... "z").characters
        let big = ("A" ... "Z").characters
        return (small + big)
            .enumerated()
            .reduce(into: [Character: Int]()) { dict, element in
                dict[element.element] = element.offset + 1
            }
    }()

    typealias Rucksack = ([Character], [Character])

    func sumOfPriorities(in input: String) -> Int {
        parse(input: input)
            .map {
                itemsApperingTwice(in: $0)
            }
            .map {
                priority(for: $0)
            }
            .reduce(0, +)
    }

    func sumOfStickers(in input: String) -> Int {
        let sacks = parse(input: input)
        let groups = sacks.chunked(into: 3)

        return groups.map {
            itemsApparingInAll(of: $0)
        }.map {
            priority(for: $0)
        }.reduce(0, +)
    }

    private func parse(input: String) -> [Rucksack] {
        input
            .split(separator: "\n")
            .map { Array($0) }
            .map { $0.split() }
    }

    private func priority(for chars: Set<Character>) -> Int {
        chars
            .map { priorities[$0]! }
            .reduce(0, +)
    }

    private func itemsApparingInAll(of rucksacks: [Rucksack]) -> Set<Character> {
        let sackOne = rucksacks[0]
        let sackTwo = rucksacks[1]
        let sackThree = rucksacks[2]

        let inAll = (sackOne.0 + sackOne.1).filter {
            (sackTwo.0 + sackTwo.1).contains($0)
        }.filter {
            (sackThree.0 + sackThree.1).contains($0)
        }

        return Set(inAll)
    }

    private func itemsApperingTwice(in rucksack: Rucksack) -> Set<Character> {
        let compA = rucksack.0
        let compB = rucksack.1

        let res = compA.filter {
            compB.contains($0)
        }

        print("TWICE: \(res) in \(rucksack)")

        return Set(res)
    }
}
