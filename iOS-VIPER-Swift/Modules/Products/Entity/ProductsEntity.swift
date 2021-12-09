//
//  ProductsEntity.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

struct Product: Decodable {
    
    let id: String?
    let name: String?
    let price: Double?
    let images: [String]?
    
    init() {
        id = ""
        name = ""
        price = 0
        images = []
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case images
    }
    
}

struct ProductList: Decodable {
    
    let totalElements: Int?
    let totalPages: Int?
    let pageNumber: Int?
    let products: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case totalElements
        case totalPages
        case pageNumber
        case products
    }
    
}
