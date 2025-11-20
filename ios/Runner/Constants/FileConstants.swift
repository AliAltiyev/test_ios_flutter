import Foundation

enum FileConstants {
    static let fileName = "output.txt"
    static let contentTemplate = "hello world"
    static let emptyString = ""
    
    static func contentFormat(counter: Int) -> String {
        return "\(contentTemplate) \(counter)"
    }
}

