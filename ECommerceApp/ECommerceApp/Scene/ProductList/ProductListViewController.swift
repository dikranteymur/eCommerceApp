//
//  ProductListViewController.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit
import DesignKit

final class ProductListViewController: BaseViewController<ProductListViewModel> {
    
    private lazy var collectionView: UICollectionView = {
        let layout = CustomCollectionFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductListCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        subscribeViewModel()
        viewModel.didLoad()
    }
}

// MARK: - UILayout
extension ProductListViewController {
    
    private func addSubviews() {
        view.addSubview(collectionView)
        collectionView.topToSuperview(usingSafeArea: true)
        collectionView.horizontalToSuperview(insets: .horizontal(20))
        collectionView.bottomToSuperview()
    }
}

// MARK: - ConfigureContents
extension ProductListViewController {
    
    private func configureContents() {
        let bagView = BagView()
        bagView.delegate = self
        bagView.bagTotalNumber = 11
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bagView)
        navigationItem.title = "Urunler"
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel.productItemModelAt(indexPath: indexPath) else { return }
        let productDetailViewController = ProductDetailBuilder.make(model: viewModel)
        productDetailViewController.modalPresentationStyle = .pageSheet
        productDetailViewController.modalTransitionStyle = .flipHorizontal
        navigationController?.present(productDetailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension ProductListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductListCell = collectionView.dequeueReusableCell(ProductListCell.self, indexPath: indexPath)
        cell.setCell(viewModel: viewModel.cellForItemAt(indexPath: indexPath))
        return cell
    }
}

// MARK: - SubscribeViewModel
extension ProductListViewController {
    
    private func subscribeViewModel() {
        viewModel.reloadData = { [weak self] isEmpty in
            guard let self = self else { return }
            if isEmpty {
                let backgroundView = UIView()
                backgroundView.backgroundColor = .colorBlack
                backgroundView.layer.cornerRadius = 12
                backgroundView.clipsToBounds = true
                let label = UILabel()
                label.text = "LISTE BOS. TEKRAR DENEYIN"
                label.numberOfLines = 0
                label.font = .fontRegular20
                label.textColor = .red
                label.textAlignment = .center
                backgroundView.addSubview(label)
                label.edgesToSuperview(insets: .uniform(40))
                collectionView.backgroundView = backgroundView
                backgroundView.centerInSuperview()
            } else {
                self.collectionView.removeBacgroundView()
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - BagViewDelegate
extension ProductListViewController: BagViewDelegate {
    
    func handleBagButtonForNavigation() {
        debugPrint("Will navigate to Shopping Bag scene")
    }
}
