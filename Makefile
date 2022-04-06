
.PHONY :  setup build test run bootstrap kill_xcode project clean

BAZEL=tools/bazelw

setup:
	build-system/setup

build:
	$(BAZEL) build //App:MyApp

test:
	$(BAZEL) test //...

run:
	$(BAZEL) run //App:MyApp

bootstrap: setup build test run
	echo "Done"

kill_xcode:
	killall Xcode || true
	killall Simulator || true

project: kill_xcode
	build-system/tulsigen build-system/tulsi/AppBazel.tulsiproj Develop

clean: kill_xcode
	rm -rf **/*.xcworkspace
	rm -rf **/*.xcodeproj
	$(BAZEL) clean
