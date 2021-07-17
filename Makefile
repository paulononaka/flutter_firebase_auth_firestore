# ==================================================================================================
# Setup and code generation
# ==================================================================================================

clean-codegen:
	find . -type f -name '*.g.dart' -delete
	find . -type f -name '*.freezed.dart' -delete
	flutter pub get
	flutter packages pub run build_runner clean

clean: clean-codegen
	flutter clean
	-rm -rf .flutter-plugins
	-rm -rf .packages
	-rm -rf build
	-rm -rf ios/DerivedData
	-rm -rf /var/folders/**/com.apple.DeveloperTools*

deep-clean: clean
	pod cache clean --all
	pod deintegrate ios/Runner.xcodeproj
	-rm -rf ~/.pub-cache
	-rm -rf ios/Pods
	-rm -rf ios/Podfile
	-rm -rf ios/Flutter/Flutter.podspec
	-rm -rf ~/Library/Developer/Xcode/{DerivedData,Archives,Products}
	-osascript -e 'tell application "iOS Simulator" to quit'
	-osascript -e 'tell application "Simulator" to quit'
	-xcrun simctl shutdown all
	-xcrun simctl erase all

watch:
	flutter packages pub run build_runner watch --delete-conflicting-outputs

codegen:
	flutter packages pub run build_runner build --delete-conflicting-outputs

install: get-packages codegen

run:
	flutter run -t lib/main.dart

upgrade:
	flutter pub upgrade
	cd ios && pod repo update
	cd ios && pod update

format: 
	flutter format . --line-length 120 | grep "Formatted"

# ==================================================================================================
# Tests
# ==================================================================================================

tests: lint

lint:
	@echo "\033[1;33m"
	@echo "------------------"
	@echo " Lint "
	@echo "------------------"
	@echo "\033[0m"
	flutter analyze

# ==================================================================================================
# Build and upload
# ==================================================================================================

# Build

build-android:
	flutter build apk -t lib/main.dart

build-ios:
	flutter build ios -t lib/main_dev.dart