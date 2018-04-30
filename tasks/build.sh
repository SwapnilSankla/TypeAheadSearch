/usr/local/bin/pod install
xcodebuild -workspace TypeAheadSearch.xcworkspace -scheme "TypeAheadSearch" clean build -derivedDataPath build -sdk iphonesimulator11.2
zip -r -X build/TypeAheadSearch.zip build/Build/Products/Debug-iphonesimulator/TypeAheadSearch.App
