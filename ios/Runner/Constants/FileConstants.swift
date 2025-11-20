import Foundation

enum FileConstants {
    static let fileName = "output.txt"
    
    static func contentFormat(counter: Int) -> String {
        return "hello world \(counter)"
    }
}

