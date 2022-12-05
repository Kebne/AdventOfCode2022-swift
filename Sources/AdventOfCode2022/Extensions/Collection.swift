import Foundation

extension Collection where Self.Iterator.Element: RandomAccessCollection {
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        guard let firstRow = first else { return [] }
        return firstRow.indices.map { index in
            self.map { $0[index] }
        }
    }
}

extension Array {
    func split() -> ([Element], [Element]) {
        let half = count / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< count]
        return (Array(leftSplit), Array(rightSplit))
    }

    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }

    func padded(to length: Int, with element: Element) -> [Element]? {
        let difference = length - count
        guard difference >= 0 else {
            // return nil if count is larger than our target length
            return nil
        }
        return self + Array(repeating: element, count: difference)
    }
}
