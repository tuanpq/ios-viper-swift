//
//  ProductDetailImagesPageViewController.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import UIKit

class ProductDetailImagesPageViewController: UIViewController {

    var presenter: ProductDetailViewToPresenterProtocol?
    
    private var numberOfPages: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let pageViewController = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        pageViewController.dataSource = self
        presenter?.imagePageView = self
        numberOfPages = presenter?.numberOfImages() ?? 1
        let firstImage = presenter?.viewControllerAt(index: 0) as! ProductDetailImageViewController
        let viewControllers: [ProductDetailImageViewController] = [firstImage]
        pageViewController.setViewControllers(viewControllers, direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
  
}

extension ProductDetailImagesPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return presenter?.imageViewControllerBefore(viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return presenter?.imageViewControllerAfter(viewController)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return numberOfPages
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return presenter?.currentlyShowingImageIndex ?? 0
    }
    
}

extension ProductDetailImagesPageViewController : ProductDetailPresenterToImagePageViewProtocol {

    func loadImageViewController() -> UIViewController? {
        return self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailImageViewController")
    }
    
}

