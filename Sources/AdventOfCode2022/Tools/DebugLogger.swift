import Foundation

class DebugLogger {
    var isEnabled: Bool = true

    func log(_ items: Any, indentationLevel: Int = 0) {
        guard isEnabled else { return }
        let indentation = Array(repeating: "\t", count: indentationLevel).joined()
        print("\(indentation)\(items)")
    }

}
