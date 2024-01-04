//
//  ProductListViewController.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit
import DesignKit

final class ProductListViewController: BaseViewController<ProductListViewModel> {
    
    private lazy var navigationBagButtonView = BagView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = CustomCollectionFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.didLoad()
    }
}

// MARK: - UILayout
extension ProductListViewController {
    
    private func addSubviews() {
        view.addSubview(collectionView)
        collectionView.topToSuperview(usingSafeArea: true)
        collectionView.horizontalToSuperview(insets: .horizontal(0))
        collectionView.bottomToSuperview()
    }
}

// MARK: - ConfigureContents
extension ProductListViewController {
    
    private func configureContents() {
        navigationBagButtonView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationBagButtonView)
        navigationItem.title = "Urunler"
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = viewModel.productItemModelAt(indexPath: indexPath) else { return }
        app.router.navigateToProductDetail(from: self, model: model)
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
        cell.delegate = self
        return cell
    }
}

// MARK: - SubscribeViewModel
extension ProductListViewController {
    
    private func subscribeViewModel() {
        viewModel.reloadData = { [weak self] isEmpty in
            guard let self = self else { return }
            if isEmpty {
                self.collectionView.backgroundView = view.setCustomEmptyView(header: "Hata!",
                                                                              info: "Bir hata meydana geldi. Lutfen tekrar deneyiniz",
                                                                              buttontitle: "Yenile") { [weak self] in
                    guard let self = self else { return }
                    debugPrint("Yenile button calisti")
                }
            } else {
                self.collectionView.removeBacgroundView()
            }
            self.collectionView.reloadData()
        }
        
        viewModel.cartInfoModel = { [weak self] cartInfoModel in
            guard let self = self else { return }
            self.navigationBagButtonView.bagTotalNumber = cartInfoModel.totalItems ?? 0
        }
    }
}

// MARK: - BagViewDelegate
extension ProductListViewController: BagViewDelegate {
    
    func handleBagButtonForNavigation() {
        app.router.navigaToShoppingBagViewController(from: self, cartInfoModel: viewModel.getCartInfoModel())
    }
}

// MARK: - ProductListCellDelegate
extension ProductListViewController: ProductListCellDelegate {
    
    func handleIsLike(id: Int, isLike: Bool) {
        viewModel.handleIsLike(id: id, isLike: isLike)
    }
    
    func addToCart(id: Int) {
        viewModel.addToCart(id: id)
    }
}
