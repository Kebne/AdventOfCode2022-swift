import Foundation

struct Eleven {

    static let debugLog = DebugLogger()

    init(debugLog: Bool = true) {
        Self.debugLog.isEnabled = debugLog
    }

    enum Value {
        case old
        case new
        case number(Int)

        init(from str: String) {
            let trimmed = str.trimmingCharacters(in: .whitespaces)
            switch trimmed {
            case "old": self = .old
            case "new": self = .new
            default: self = .number(Int(trimmed)!)
            }
        }

        func value(for item: Int) -> Int {
            switch self {
            case let .number(number): return number
            case .old: return item
            case .new: fatalError()
            }
        }
    }

    enum Test {
        case divisible(by: Int, ifTrue: Int, ifFalse: Int)

        var divisor: Int {
            switch self {
            case .divisible(let by, _, _):
                return by
            }
        }

        func test(on item: Int) -> Int {
            switch self {
            case let .divisible(by, ifTrue, ifFalse):
                debugLog.log("Testing if \(item) is devisible by \(by)", indentationLevel: 2)
                if item % by == 0 {
                    debugLog.log("true", indentationLevel: 3)
                    return ifTrue
                } else {
                    debugLog.log("false", indentationLevel: 3)
                    return ifFalse
                }
            }
        }
    }

    enum Operation {
        case multiply(Value, Value)
        case plus(Value, Value)

        init(operator op: Character, values: [Value]) {
            switch op {
            case "+": self = .plus(values.first!, values.last!)
            case "*": self = .multiply(values.first!, values.last!)
            default: fatalError()
            }
        }

        func apply(to item: Int) -> Int {
            switch self {
            case let .multiply(v1, v2):
                debugLog.log("Worry level is multiplied: \(v1) * \(v2)", indentationLevel: 2)
                return v1.value(for: item) * v2.value(for: item)
            case let .plus(v1, v2):
                debugLog.log("Worry level is added: \(v1) * \(v2)", indentationLevel: 2)
                return v1.value(for: item) + v2.value(for: item)
            }
        }
    }

    class Monkey {
        var inspectCounter = 0
        let id: Int
        var items: [Int]
        let operation: Operation
        let test: Test

        init(id: Int, items: [Int], operation: Operation, test: Test) {
            self.id = id
            self.items = items
            self.operation = operation
            self.test = test
        }
    }

    func monkeyBusinessOne(input: String) -> Int {
        let monkeys = parsed(input: input)
        return run(with: monkeys, rounds: 20) { $0 / 3}
    }

    func monkeyBusinessTwo(input: String) -> Int {
        let monkeys = parsed(input: input)
        let divisorModulus = monkeys.map { $0.test.divisor }.reduce(1, *)
        return run(with: monkeys, rounds: 10000) { $0 % divisorModulus }
    }

    private func run(with monkeys: [Monkey], rounds: Int, reduceWorry: (Int) -> (Int) ) -> Int {
        for _ in 1...rounds {

            for monkey in monkeys {

                Self.debugLog.log("Monkey \(monkey.id)")
                for item in monkey.items {
                    Self.debugLog.log("Monkey inspect item with worry level \(item)", indentationLevel: 1)
                    monkey.inspectCounter += 1
                    let newItem = reduceWorry(monkey.operation.apply(to: item))
                    let to = monkey.test.test(on: newItem)
                    monkeys.first { $0.id == to }!.items.append(newItem)
                }

                monkey.items = []
            }
        }

        let sorted = monkeys.sorted { $0.inspectCounter > $1.inspectCounter }
        return sorted[0].inspectCounter * sorted[1].inspectCounter
    }

    private func parsed(input: String) -> [Monkey] {
        input
            .split(omittingEmptySubsequences: true) { $0.isNewline }
            .chunked(into: 6)
            .map { parseMonkey(input: $0) }
    }

    private func parseMonkey(input split: [Substring]) -> Monkey {
        let number = Int(split.first!.split(separator: " ").last!.replacingOccurrences(of: ":", with: ""))!
        let items = split[1]
            .split(separator: ":")
            .last!
            .split(separator: ",")
            .map { Int($0.trimmingCharacters(in: .whitespaces))! }
        let operationStr = String(split[2]
            .split(separator: "=")
            .last!)

        let separator: Character
        if operationStr.contains("+") {
            separator = "+"
        } else if operationStr.contains("*") {
            separator = "*"
        } else {
            fatalError()
        }
        let values = operationStr
            .split(separator: separator)
            .map { Value(from: String($0)) }
        let operation = Operation(operator: separator, values: values)

        let divisible = Int(split[3].replacingOccurrences(of: "Test: divisible by ", with: "").trimmingCharacters(in: .whitespaces))!
        let ifTrue = Int(split[4].replacingOccurrences(of: "If true: throw to monkey ", with: "").trimmingCharacters(in: .whitespaces))!
        let ifFalse = Int(split[5].replacingOccurrences(of: "If false: throw to monkey ", with: "").trimmingCharacters(in: .whitespaces))!

        let test = Test.divisible(by: divisible, ifTrue: ifTrue, ifFalse: ifFalse)
        return Monkey(id: number, items: items, operation: operation, test: test)
    }
}
