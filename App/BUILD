load("//build-system:custom_rules.bzl", "application")

licenses(["notice"])

application(
    name = "MyApp",
    infoplist = "Supports/Info.plist",
    app_icons = [
        "//App/Resources:AppIcon",
    ],
    resources = [
        "//App/Resources:Assets"
    ],
    deps = [
        "//modules/Logging:TLLogging",
    ],
)