//
//  ProductsService.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

class ProductsService {
    
    static let shared = {
        ProductsService()
    }()
    
    func getProductsAt(page: Int, size: Int, success: @escaping ([Product]) -> (), failure: @escaping () -> ()) {
        let useLocalJSONFile = true
        
        if (useLocalJSONFile) {
            FileManager.shared.readContentFromJSONFile(withFileName: "products") { (productList: ProductList) in
                guard let products = productList.products else {
                    success([])
                    return
                }
                success(products)
            } failure: {
                failure()
            }
        } else {
            let urlString = APIManager.shared.baseURL + Endpoints.PRODUCTS + "?page=\(page)&size=\(size)"
            
            APIClient.shared.request(urlString: urlString, success: { (productList: ProductList) in
                guard let products = productList.products else {
                    success([])
                    return
                }
                success(products)
            }) { () in
                failure()
            }
        }
    }

}

