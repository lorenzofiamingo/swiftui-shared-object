import XCTest
@testable import SharedObject

final class SharedObjectTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SharedObject().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
