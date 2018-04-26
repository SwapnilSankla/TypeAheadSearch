/usr/local/bin/pod install
xcodebuild -workspace TypeAheadSearch.xcworkspace -scheme "TypeAheadSearch" -destination 'platform=iOS Simulator,OS=11.3,name=iPhone 6s' -archivePath clean build -derivedDataPath build
zip -r -X build/TypeAheadSearch.zip build/Build/Products/Debug-iphonesimulator/TypeAheadSearch.App
