/usr/local/bin/pod install
xcodebuild -workspace TypeAheadSearch.xcworkspace -scheme "TypeAheadSearch" -destination 'platform=iOS Simulator,OS=11.3,name=iPad Pro (9.7-inch)' -archivePath clean build -derivedDataPath build
zip -r -X build/TypeAheadSearch.zip build/Build/Products/Debug-iphonesimulator/TypeAheadSearch.App
