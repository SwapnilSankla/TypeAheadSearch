pod install
xcodebuild -workspace TypeAheadSearch.xcworkspace -scheme "TypeAheadSearch" -destination 'platform=iOS Simulator,OS=11.3,name=iPhone 6s' clean build
