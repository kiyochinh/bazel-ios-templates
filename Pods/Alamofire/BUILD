load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "Alamofire",
    module_name = "Alamofire",
    srcs = glob(
        ["Source/**/*.swift", "Alamofire/**/*.swift"],
        exclude= ["Examples/**/*.swift"]
    ),
    visibility = ["//visibility:public"],
)