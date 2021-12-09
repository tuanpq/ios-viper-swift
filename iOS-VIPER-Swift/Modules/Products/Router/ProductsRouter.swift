//
//  ProductsRouter.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import UIKit

class ProductsRouter: ProductsPresenterToRouterProtocol {

    static func createModule() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        let presenter: ProductsViewToPresenterProtocol & ProductsInteractorToPresenterProtocol = ProductsPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ProductsInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.router = ProductsRouter()
        
        return navigationController
    }
    
    func pushToProductDetail(on view: ProductsPresenterToViewProtocol, with product: Product) {
        let productDetailViewController = ProductDetailRouter.createModule(with: product) as! ProductDetailViewController
        let viewController = view as! ProductsViewController
        productDetailViewController.product = product
        viewController.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
    
}
