import Foundation

final class FileService {
    private let filePath: String
    
    init() {
        let documentsPath = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        filePath = documentsPath.appendingPathComponent(FileConstants.fileName).path
    }
    
    func writeToFile(content: String) -> Int32 {
        return filePath.withCString { filePathCStr in
            content.withCString { contentCStr in
                write_to_file(filePathCStr, contentCStr)
            }
        }
    }
    
    func readFile() throws -> String {
        return try String(contentsOfFile: filePath, encoding: .utf8)
    }
    
    func fileExists() -> Bool {
        return FileManager.default.fileExists(atPath: filePath)
    }
}

