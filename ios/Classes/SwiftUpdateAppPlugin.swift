import Flutter
import UIKit

public class SwiftUpdateAppPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mofada.cn/update_app", binaryMessenger: registrar.messenger())
        let instance = SwiftUpdateAppPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "updateApp":
            goAppStore(call: call, result: result)
            break;
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
            break;
        default:
            result(FlutterMethodNotImplemented)
        }
    }


    // 跳转Apple Store
    func goAppStore(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments else {
            result("arguments is empty")
            return
        }

        if let arguments = args as? [String: Any]{
            if let appleStoreUrl = arguments["appleStoreUrl"] as? String{
                if let url = URL(string: appleStoreUrl) ,UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:])
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                    result(0)
                } else {
                    result("ios can't open app store page")
                }
            } else {
                result("appleStoreUrl is empty")
            }
        } else {
            result("arguments type not correct")
        }
    }
}
