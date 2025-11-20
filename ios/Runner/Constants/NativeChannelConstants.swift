import Foundation

enum NativeChannelConstants {
    static let channelName = "com.example.test_ios_flutter/native"
    
    enum Method {
        static let writeToFile = "writeToFile"
        static let readFile = "readFile"
    }
    
    enum Parameter {
        static let counter = "counter"
    }
    
    enum ErrorCode {
        static let unavailable = "UNAVAILABLE"
        static let invalidArgument = "INVALID_ARGUMENT"
        static let writeError = "WRITE_ERROR"
        static let readError = "READ_ERROR"
    }
    
    enum ErrorMessage {
        static let unavailable = "AppDelegate is unavailable"
        static let invalidArguments = "Invalid arguments"
        static let writeFailed = "Failed to write to file"
        static let readFailed = "Failed to read file"
    }
}

