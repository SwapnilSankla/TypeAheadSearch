import XCTest

class TypeAheadSearchUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication(bundleIdentifier: "sankla.swapnil.TypeAheadSearch")
        app.launch()
    }

    override func tearDown() {
        app.terminate()
    }

    func testSearchFeature() {
        let searchText = app.textFields["textInput"]
        searchText.tap()
        searchText.typeText("Swapnil")

        let searchButton = app.buttons["Search"]
        searchButton.tap()

        let searchResultText = app.staticTexts["searchResultText"]
        XCTAssertEqual("Swapnil",searchResultText.label)
    }

    func testTypeAheadSearchFeature() {
        let searchText = app.textFields["textInput"]
        searchText.tap()
        searchText.typeText("aa")

        let searchList = app.tables["SearchList"]
        waitFor(element: searchList, seconds: 10)

        searchList.cells["SearchList_5"].tap()
        XCTAssertEqual("aaru",searchText.value as! String)

        let searchButton = app.buttons["Search"]
        searchButton.tap()

        let searchResultText = app.staticTexts["searchResultText"]
        XCTAssertEqual("aaru",searchResultText.label)
    }

    func testAppVersion() {
        let appVersion = app.staticTexts["buildVersion"]
        XCTAssertEqual("1.0.DEV",appVersion.label)
    }

    func waitFor(element:XCUIElement, seconds waitSeconds:Double) {
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: waitSeconds, handler: nil)
    }
}
