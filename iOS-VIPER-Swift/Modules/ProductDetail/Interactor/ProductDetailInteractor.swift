//
//  ProductDetailInteractor.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import Foundation

// MARK: Called at Interactor, implemented at Presenter
protocol ProductDetailInteractorToPresenterProtocol {
    
}

class ProductDetailInteractor: ProductDetailPresenterToInteractorProtocol {
    
    var product: Product?
    var presenter: ProductDetailInteractorToPresenterProtocol?
    
}
