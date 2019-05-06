import Foundation
import UIKit
import Kanna
import SQLite3
import SQLite

class Helper {
    static func copyDbToDocument() {
        let bundlePath = Bundle.main.path(forResource: "funny", ofType: "db")
//        print(bundlePath!) //prints the correct path
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let destPath = (paths[0] as NSString).appendingPathComponent("funny.db")
        let fileManager = FileManager.default
//        print(fileManager.fileExists(atPath: bundlePath!)) // prints true
        let didExist = fileManager.fileExists(atPath: bundlePath!)
        if didExist == true { return }
        do {
            try fileManager.copyItem(atPath: bundlePath!, toPath: destPath)
        } catch {
            print("\n")
            print(error)
        }
    }
    
    static func parseHTMLContent(_ content: String, completionHandler: @escaping (Bool, String)->Void) {
        DispatchQueue.global().async {
            let html = content.removeRedundantHTMLCharaters()
            
            if let doc = try? HTML(html: html, encoding: .utf8) {
                var contentExpect = ""
                for p in doc.xpath("//p") {
                    contentExpect.append(p.text!)
                    contentExpect.append(" \n")
                }
                completionHandler(true, contentExpect)
            }
            else {
                completionHandler(false, content)
            }
        }
    }
    
    static func copyDatabaseIfNeeded() {
        // Move database file from bundle to documents folder
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        guard documentsUrl.count != 0 else {
            return // Could not find documents URL
        }
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent("funny.db")
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent("funny.db")
            do {
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
    }
}

extension String {
    func removeRedundantHTMLCharaters() -> String {
        let output = replacingOccurrences(of: "<br/>", with: " \n")
        return output
    }
}


