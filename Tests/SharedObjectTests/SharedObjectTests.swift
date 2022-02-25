import XCTest
@testable import SharedObject

final class SharedObjectTests: XCTestCase {
	
	@SharedObject("A") var letterA = Letter()
	
	@SharedObject("B") var letterB1 = Letter()
	@SharedObject("B") var letterB2: Letter
	
	@SharedObject("C") var letterC: LetterWithInitialValueC
	
	func testInit() {
		letterA.value = "A"
		XCTAssertEqual(letterA.value, "A")
	}
	
	func testRepository() {
		letterB1.value = "B"
		XCTAssertEqual(letterB2.value, "B")
	}
	
	func testSharableObject() {
		XCTAssertEqual(letterC.value, "C")
	}
	
	static var allTests = [
		("testInit", testInit),
		("testRepository", testRepository),
		("testSharableObject", testSharableObject),
	]
	
	final class Letter: ObservableObject {
		var value = ""
	}
	
	final class LetterWithInitialValueC: SharableObject {
		
		var value: String
		
		init(_ value: String) {
			self.value = value
		}
		
		static var initialValue: Self {
			.init("C")
		}
	}
}
