load("//build-system:custom_rules.bzl", "application")

licenses(["notice"])

application(
    name = "{PROJECT_NAME}",
    infoplist = "Configurations/Plists/Info.plist",
    app_icons = [
        "//{PROJECT_NAME}/Resources:AppIcon",
    ],
    resources = [
        "//{PROJECT_NAME}/Resources:Assets"
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