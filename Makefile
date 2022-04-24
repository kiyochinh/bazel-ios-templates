
.PHONY :  setup build test run bootstrap kill_xcode project clean

BAZEL=tools/bazelw

init:
	sh build-system/make.sh --bundle-id $(BUNDLE_ID) --project-name $(PROJECT_NAME)

install:
	build-system/install

build:
	$(BAZEL) build //{PROJECT_NAME}:{PROJECT_NAME}

test:
	$(BAZEL) test //...

run:
	$(BAZEL) run //{PROJECT_NAME}:{PROJECT_NAME}

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
