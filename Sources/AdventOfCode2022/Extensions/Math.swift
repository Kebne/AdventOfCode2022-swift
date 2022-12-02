import Foundation

func mod(_ a: Int, _ n: Int) -> Int {
    assert(n > 0, "modulus must be positive")
    let r = a % n
    return r >= 0 ? r : r + n
}
