//
//  ProductDetailImageViewController.swift
//  iOS-VIPER-Swift
//
//  Created by Tuan Pham on 09/12/2021.
//

import UIKit

class ProductDetailImageViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var index: Int = 0
    var imageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupContent()
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 24
        containerView.clipsToBounds = true
    }
    
    private func setupContent() {
        imageView.sd_setImage(with: URL(string: imageURL ?? ""), placeholderImage: nil)
    }

}
