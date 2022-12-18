import Foundation

func paddedZip<T, U, Sequence1, Sequence2>(
    _ sequence1: Sequence1,
    _ sequence2: Sequence2
    ) -> Zip2Sequence<[T?], [U?]> where
    Sequence1 : Sequence, Sequence1.Element == T,
    Sequence2 : Sequence, Sequence2.Element == U {
        var array1: [T?] = []
        var array2: [U?] = []

        var iterator1 = sequence1.makeIterator()
        var iterator2 = sequence2.makeIterator()

        var shouldContinue = true

        while shouldContinue {
            switch (iterator1.next(), iterator2.next()) {
            case (.some(let element1), .some(let element2)):
                array1.append(.some(element1))
                array2.append(.some(element2))
            case (.some(let element1), .none):
                array1.append(.some(element1))
                array2.append(.none)
            case (.none, .some(let element2)):
                array1.append(.none)
                array2.append(.some(element2))
            case (.none, .none):
                shouldContinue = false
            }
        }

        return zip(array1, array2)
}

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
