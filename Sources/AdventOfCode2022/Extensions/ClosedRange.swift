import Foundation

extension ClosedRange where Bound == Unicode.Scalar {
    var range: ClosedRange<UInt32>  { lowerBound.value...upperBound.value }
    var scalars: [Unicode.Scalar]   { range.compactMap(Unicode.Scalar.init) }
    var characters: [Character]     { scalars.map(Character.init) }
}

extension ClosedRange {
    func isCovered(by other: ClosedRange) -> Bool {
        if lowerBound >= other.lowerBound && upperBound <= other.upperBound {
            return true
        }

        return false
    }

    func hasOverlap(with other: ClosedRange) -> Bool {
        if lowerBound >= other.lowerBound && lowerBound <= other.upperBound {
            return true
        }

        if upperBound >= other.lowerBound && upperBound <= other.upperBound {
            return true
        }

        return false
    }
}

extension String {
    init<S: Sequence>(_ sequence: S) where S.Element == Unicode.Scalar {
        self.init(UnicodeScalarView(sequence))
    }
}
