//
//  ProductDetailPresenter.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import Foundation
import UIKit

// MARK: Called at Presenter, implemented at Router
protocol ProductDetailPresenterToRouterProtocol {
    
    static func createModule(with product: Product) -> UIViewController
    
}

// MARK: Called at Presenter, implemented at View/ViewController
protocol ProductDetailPresenterToViewProtocol {
    
}

// MARK: Called at Presenter, implemented at View/ViewController
protocol ProductDetailPresenterToImagePageViewProtocol {
    
    func loadImageViewController() -> UIViewController?
    
}

// MARK: Called at Presenter, implemented at View/Interactor
protocol ProductDetailPresenterToInteractorProtocol {
    
    var product: Product? { get set }
    var presenter: ProductDetailInteractorToPresenterProtocol? { get set }
    
}

class ProductDetailPresenter: ProductDetailViewToPresenterProtocol {
    
    var view: ProductDetailPresenterToViewProtocol?
    var imagePageView: ProductDetailPresenterToImagePageViewProtocol?
    var interactor: ProductDetailPresenterToInteractorProtocol?
    var router: ProductDetailPresenterToRouterProtocol?
    var currentlyShowingImageIndex: Int?
    
    func viewDidLoad() {
        
    }

    func numberOfImages() -> Int {
        return interactor?.product?.images?.count ?? 1
    }
    
    func viewControllerAt(index: Int) -> UIViewController? {
        if let viewController = imagePageView?.loadImageViewController() as? ProductDetailImageViewController {
            self.setImage(for: viewController, at: index)
            return viewController
        } else {
            return nil
        }
    }
    
    func imageViewControllerBefore(_ viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? ProductDetailImageViewController {
            var index = viewController.index
            if index == 0 {
                return nil
            }
            index += -1
            self.currentlyShowingImageIndex = index
            if let imageViewController = imagePageView?.loadImageViewController() as? ProductDetailImageViewController {
                self.setImage(for: imageViewController, at: index)
                return imageViewController
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    func imageViewControllerAfter(_ viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? ProductDetailImageViewController {
            var index = viewController.index
            index += 1
            if index == numberOfImages() {
                return nil
            }
            self.currentlyShowingImageIndex = index
            if let imageViewController = imagePageView?.loadImageViewController() as? ProductDetailImageViewController {
                self.setImage(for: imageViewController, at: index)
                return imageViewController
            } else {
                return nil
            }
        }
                
        return nil
    }
    
    func setImage(for imageViewController: ProductDetailImageViewController, at index: Int) {
        imageViewController.index = index
        imageViewController.imageURL = interactor?.product?.images?[index]
    }

}

extension ProductDetailPresenter: ProductDetailInteractorToPresenterProtocol {
    
}

