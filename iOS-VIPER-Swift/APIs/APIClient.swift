//
//  APIClient.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import Foundation
import Alamofire

class APIClient {
    
    var baseURL: URL?
    
    static let shared = {
        APIClient(baseUrl: APIManager.shared.baseURL)
    }()
    
    required init(baseUrl: String) {
        self.baseURL = URL(string: baseUrl)
    }
    
    func request<T: Decodable>(urlString: String, success: @escaping (T) -> (), failure: @escaping () -> ()) {
        AF.request(urlString).responseDecodable(of: T.self) { (response) in
            guard let result = response.value else {
                failure()
                return
            }
            success(result)
        }
    }
    
}
