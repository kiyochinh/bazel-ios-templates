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
        "//third-party/Alamofire",
        "//third-party/IQKeyboardManager",
        "//third-party/Kingfisher",
        "//third-party/ObjectMapper",
        "//third-party/SnapKit",
        "//modules/Logging:TLLogging",
    ],
)