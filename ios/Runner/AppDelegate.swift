import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let fileService = FileService()
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupMethodChannel()
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func setupMethodChannel() {
        guard let controller = window?.rootViewController as? FlutterViewController else {
            return
        }
        
        let nativeChannel = FlutterMethodChannel(
            name: NativeChannelConstants.channelName,
            binaryMessenger: controller.binaryMessenger
        )
        
        nativeChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let self = self else {
                result(FlutterError(
                    code: NativeChannelConstants.ErrorCode.unavailable,
                    message: NativeChannelConstants.ErrorMessage.unavailable,
                    details: nil
                ))
                return
            }
            
            self.handleMethodCall(call: call, result: result)
        }
    }
    
    private func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case NativeChannelConstants.Method.writeToFile:
            handleWriteToFile(call: call, result: result)
            
        case NativeChannelConstants.Method.readFile:
            handleReadFile(result: result)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func handleWriteToFile(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let counter = args[NativeChannelConstants.Parameter.counter] as? Int else {
            result(FlutterError(
                code: NativeChannelConstants.ErrorCode.invalidArgument,
                message: NativeChannelConstants.ErrorMessage.invalidArguments,
                details: nil
            ))
            return
        }
        
        let content = FileConstants.contentFormat(counter: counter)
        let writeResult = fileService.writeToFile(content: content)
        
        if writeResult == 0 {
            result(true)
        } else {
            result(FlutterError(
                code: NativeChannelConstants.ErrorCode.writeError,
                message: NativeChannelConstants.ErrorMessage.writeFailed,
                details: writeResult
            ))
        }
    }
    
    private func handleReadFile(result: @escaping FlutterResult) {
        do {
            let content = try fileService.readFile()
            result(content)
        } catch {
            result(FileConstants.emptyString)
        }
    }
}
