//
//  ProductsInteractor.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import UIKit

// MARK: Called at Interactor, implemented at Presenter
protocol ProductsInteractorToPresenterProtocol {
    
    func didGetProductsSuccess(products: [Product])
    func didGetProductsFailure()
    func didGetProductSuccess(product: Product)
    func didGetProductFailure()
    
}

class ProductsInteractor: ProductsPresenterToInteractorProtocol {
    
    var presenter: ProductsInteractorToPresenterProtocol?
    var products: [Product]?
    
    func getProductsAt(page: Int, size: Int) {
        ProductsService.shared.getProductsAt(page: page, size: size) { products in
            self.products = products
            self.presenter?.didGetProductsSuccess(products: products)
        } failure: {
            self.presenter?.didGetProductsFailure()
        }
    }
    
    func getProductAt(index: Int) {
        guard let products = self.products, products.indices.contains(index) else {
            self.presenter?.didGetProductFailure()
            return
        }
        self.presenter?.didGetProductSuccess(product: self.products![index])
    }
    
}
