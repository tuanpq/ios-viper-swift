//
//  APIManager.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import Foundation

class APIManager {
    
    static let shared = {
        APIManager()
    }()
    
    lazy var baseURL: String = {
        return "http://localhost:8080/api/"
    }()
    
}
