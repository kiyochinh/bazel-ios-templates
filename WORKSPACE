load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "build_bazel_rules_apple",
    sha256 = "4161b2283f80f33b93579627c3bd846169b2d58848b0ffb29b5d4db35263156a",
    url = "https://github.com/bazelbuild/rules_apple/releases/download/0.34.0/rules_apple.0.34.0.tar.gz",
)

load(
    "@build_bazel_rules_apple//apple:repositories.bzl",
    "apple_rules_dependencies",
)

apple_rules_dependencies()

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()

load(
    "@build_bazel_rules_swift//swift:extras.bzl",
    "swift_rules_extra_dependencies",
)

swift_rules_extra_dependencies()

load(
    "@build_bazel_apple_support//lib:repositories.bzl",
    "apple_support_dependencies",
)

apple_support_dependencies()

load(
    "@com_google_protobuf//:protobuf_deps.bzl",
    "protobuf_deps",
)

protobuf_deps()

# External Dependencies

http_archive(
    name = "Alamofire",
    urls = ["https://github.com/Alamofire/Alamofire/archive/5.6.1.zip"],
    sha256 = "7ca31b412d017b35d6caddc212fcf3463a3f3498dae3a17b5a18c30fabefa41d",
    build_file = "@//:Pods/Alamofire/BUILD",
    strip_prefix = "Alamofire-5.6.1"
)

http_archive(
    name = "RxSwift",
    urls = ["https://github.com/ReactiveX/RxSwift/archive/6.5.0.zip"],
    sha256 = "64d79e18d200ad5fd122e4c74faae8fa7909287ba4942b71cc060fd4e45d8162",
    build_file = "@//:Pods/RxSwift/BUILD",
    strip_prefix = "RxSwift-6.5.0"
)

http_archive(
    name = "ObjectMapper",
    urls = ["https://github.com/tristanhimmelman/ObjectMapper/archive/4.2.0.zip"],
    sha256 = "3bc5ee1820b6cf222fbb1e30298cd55f54253340343b43210564b53cc39c164e",
    build_file = "@//:Pods/ObjectMapper/BUILD",
    strip_prefix = "ObjectMapper-4.2.0"
)

http_archive(
    name = "IQKeyboardManager",
    urls = ["https://github.com/hackiftekhar/IQKeyboardManager/archive/v6.5.0.zip"],
    sha256 = "9b41e43b2902493904c580a90bb667ae6f5b4e9f35d984765256c4b46f069b75",
    build_file = "@//:Pods/IQKeyboardManager/BUILD",
    strip_prefix = "IQKeyboardManager-6.5.0"
)