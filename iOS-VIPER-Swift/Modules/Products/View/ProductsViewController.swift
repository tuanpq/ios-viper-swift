//
//  ProductsViewController.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import UIKit

// MARK: Called at View/ViewController, implemented at Presenter
protocol ProductsViewToPresenterProtocol {
    
    var view: ProductsPresenterToViewProtocol? { get set }
    var interactor: ProductsPresenterToInteractorProtocol? { get set }
    var router: ProductsPresenterToRouterProtocol? { get set }
    var products: [Product]? { get set }
    
    func viewDidLoad()
    func refresh()
    func numberOfItemsInSection() -> Int
    func setProduct(for productCollectionViewCell: ProductCollectionViewCell, at indexPath: Int)
    func didSelectItemAt(index: Int)
    func deselectItemAt(index: Int)
    
}

class ProductsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlow: UICollectionViewFlowLayout!
    
    var presenter: ProductsViewToPresenterProtocol?
    
    private let reuseIdentifier = "ProductCollectionViewCell"
    private let sectionInsets = UIEdgeInsets(top: 24.0, left: 24.0, bottom: 24.0, right: 24.0)
    private let itemsPerRow: CGFloat = 2
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    func setupUI() {
        collectionView!.alwaysBounceVertical = true
        collectionView!.refreshControl = refreshControl
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        presenter?.refresh()
    }
    
}

extension ProductsViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItemAt(index: indexPath.row)
        presenter?.deselectItemAt(index: indexPath.row)
    }
    
}

extension ProductsViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        presenter?.setProduct(for: productCell, at: indexPath.row)
        return productCell
    }
    
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem + 120 //48 + 12 + 48 + 12
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

extension ProductsViewController: ProductsPresenterToViewProtocol {
    
    func onFetchProductsSuccess() {
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func onFetchProductsFailure() {
        self.refreshControl.endRefreshing()
    }
    
    func deselectItemAt(row: Int) {
        self.collectionView.deselectItem(at: IndexPath(row: row, section: 0), animated: true)
    }
    
}
