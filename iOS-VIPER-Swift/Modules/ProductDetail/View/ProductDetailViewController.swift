//
//  ProductDetailViewController.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import Foundation
import UIKit

// MARK: Called at View/ViewController, implemented at Presenter
protocol ProductDetailViewToPresenterProtocol {
    
    var view: ProductDetailPresenterToViewProtocol? { get set }
    var imagePageView: ProductDetailPresenterToImagePageViewProtocol? { get set }
    var interactor: ProductDetailPresenterToInteractorProtocol? { get set }
    var router: ProductDetailPresenterToRouterProtocol? { get set }
    var currentlyShowingImageIndex: Int? {get set}
    
    func numberOfImages() -> Int
    func viewControllerAt(index: Int) -> UIViewController?
    func imageViewControllerBefore(_ viewController: UIViewController) -> UIViewController?
    func imageViewControllerAfter(_ viewController: UIViewController) -> UIViewController?
    
}

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var imagesView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var presenter: ProductDetailViewToPresenterProtocol?
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
   
}

extension ProductDetailViewController {
    
    func setupUI() {
        let productDetailImagesPageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailImagesPageViewController") as! ProductDetailImagesPageViewController
        productDetailImagesPageViewController.presenter = presenter
        addChild(productDetailImagesPageViewController)
        productDetailImagesPageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        imagesView.addSubview(productDetailImagesPageViewController.view)
        NSLayoutConstraint.activate([
            productDetailImagesPageViewController.view.topAnchor.constraint(equalTo: imagesView.topAnchor, constant: 0.0),
            productDetailImagesPageViewController.view.bottomAnchor.constraint(equalTo: imagesView.bottomAnchor, constant: 0.0),
            productDetailImagesPageViewController.view.leadingAnchor.constraint(equalTo: imagesView.leadingAnchor, constant: 0.0),
            productDetailImagesPageViewController.view.trailingAnchor.constraint(equalTo: imagesView.trailingAnchor, constant: 0.0),
        ])
        productDetailImagesPageViewController.didMove(toParent: self)
        
        nameLabel.text = product?.name
        priceLabel.text = "\(product?.price ?? 0) VNĐ"
    }
    
}

extension ProductDetailViewController: ProductDetailPresenterToViewProtocol {
    
}
