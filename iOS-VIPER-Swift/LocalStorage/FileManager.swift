//
//  FileManager.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import Foundation

class FileManager {
    
    static let shared = {
        FileManager()
    }()
    
    func readContentFromJSONFile<T: Decodable>(withFileName: String, success: @escaping (T) -> (), failure: @escaping () -> ()) {
        guard let path = Bundle.main.path(forResource: withFileName, ofType: "json") else {
            return
        }

        do {
            let url = URL(fileURLWithPath: path)
            let jsonData = try Data(contentsOf: url)
            let jsonObject: T = try! JSONDecoder().decode(T.self, from: jsonData)
            success(jsonObject)
        } catch {
            print(error)
            failure()
        }
    }
    
}
