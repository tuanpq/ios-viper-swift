//
//  ProductDetailRouter.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import Foundation
import UIKit

class ProductDetailRouter: ProductDetailPresenterToRouterProtocol {
    
    static func createModule(with product: Product) -> UIViewController {
        let storyboard = UIStoryboard(name: "ProductDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        let presenter: ProductDetailViewToPresenterProtocol & ProductDetailInteractorToPresenterProtocol = ProductDetailPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ProductDetailInteractor()
        viewController.presenter?.interactor?.product = product
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.router = ProductDetailRouter()
        
        return viewController
    }
    
}
