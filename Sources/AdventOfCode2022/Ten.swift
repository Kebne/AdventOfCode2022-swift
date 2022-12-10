import Foundation

struct Ten {
    enum Instruction {
        case noop
        case addx(Int)
    }

    class ClockCircuit {
        private(set) var registerX = 1
        private(set) var cycle = 0
        private var instructions: [Instruction] = []
        private var currentInstruction: Instruction?

        var isDone: Bool { instructions.isEmpty && currentInstruction == nil }

        init(instructions: [Instruction]) {
            self.instructions = instructions
        }

        func run() {
            cycle += 1
            guard let currentInstruction else {
                let next = instructions.first!
                instructions = Array(instructions.suffix(from: 1))

                switch next {
                case .noop:
                    break
                case .addx:
                    self.currentInstruction = next
                }
                return
            }

            if case let .addx(value) = currentInstruction {
                registerX += value
            } else {
                assertionFailure("Unknown state")
            }
            self.currentInstruction = nil
        }
    }

    func displayOutput(input: String) -> String {
        let circut = ClockCircuit(instructions: parsed(input: input))
        var currentRow = ""
        var rows: [String] = []

        while circut.isDone == false || rows.count < 6 {
            let value = abs(circut.registerX - (circut.cycle % 40)) <= 1 ? "#" : "."
            currentRow += value
            if currentRow.count > 39 {
                rows.append(currentRow)
                currentRow = ""
            }
            circut.run()
        }

        return rows.joined(separator: "\n")
    }

    func signalStrength(input: String) -> Int {
        let circut = ClockCircuit(instructions: parsed(input: input))
        var nextWatch = 20
        var signalStrength = 0

        while circut.isDone == false || nextWatch <= 220 {
            if circut.cycle == nextWatch - 1 {
                signalStrength += nextWatch * circut.registerX
                nextWatch += 40
            }
            circut.run()
        }

        return signalStrength
    }

    private func parsed(input: String) -> [Instruction] {
        input
            .split(separator: "\n")
            .map { $0.split(separator: " ") }
            .map {
                switch $0.first! {
                case "noop": return .noop
                case "addx": return .addx(Int($0.last!)!)
                default: fatalError()
                }
            }
    }
}
