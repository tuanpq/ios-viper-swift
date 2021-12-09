//
//  ProductsPresenter.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import UIKit

// MARK: Called at Presenter, implemented at Router
protocol ProductsPresenterToRouterProtocol {
    
    static func createModule() -> UINavigationController
    func pushToProductDetail(on view: ProductsPresenterToViewProtocol, with product: Product)
    
}

// MARK: Called at Presenter, implemented at View/ViewController
protocol ProductsPresenterToViewProtocol {
    
    func onFetchProductsSuccess()
    func onFetchProductsFailure()
    func deselectItemAt(row: Int)
    
}

// MARK: Called at Presenter, implemented at Interactor
protocol ProductsPresenterToInteractorProtocol {
    
    var presenter: ProductsInteractorToPresenterProtocol? { get set }
    
    func getProductsAt(page: Int, size: Int)
    func getProductAt(index: Int)
    
}

class ProductsPresenter: ProductsViewToPresenterProtocol {
    
    var view: ProductsPresenterToViewProtocol?
    var interactor: ProductsPresenterToInteractorProtocol?
    var router: ProductsPresenterToRouterProtocol?
    var products: [Product]?
    
    func viewDidLoad() {
        interactor?.getProductsAt(page: 0, size: 6)
    }
    
    func refresh() {
        interactor?.getProductsAt(page: 0, size: 6)
    }
    
    func numberOfItemsInSection() -> Int {
        guard let productList = self.products else {
            return 0
        }
        
        return productList.count
    }
    
    func setProduct(for productCollectionViewCell: ProductCollectionViewCell, at index: Int) {
        guard let product = self.products?[index] else {
            return
        }
        
        productCollectionViewCell.setContent(with: product)
    }
    
    func didSelectItemAt(index: Int) {
        interactor?.getProductAt(index: index)
    }
    
    func deselectItemAt(index: Int) {
        view?.deselectItemAt(row: index)
    }

}

extension ProductsPresenter: ProductsInteractorToPresenterProtocol {
    
    func didGetProductsSuccess(products: [Product]) {
        self.products = products
        view?.onFetchProductsSuccess()
    }
    
    func didGetProductsFailure() {
        view?.onFetchProductsFailure()
    }
    
    func didGetProductSuccess(product: Product) {
        router?.pushToProductDetail(on: view!, with: product)
    }
    
    func didGetProductFailure() {
        
    }
    
}

