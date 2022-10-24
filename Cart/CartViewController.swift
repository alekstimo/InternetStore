//
//  CartViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import UIKit
import RealmSwift

class CartViewController: UIViewController {

    let realm = try! Realm()
    var sum: Double = 0.0
    var isAllSelected: Bool = false
    var currentStatus = OrderStatus()
    var model: [Purchase] = []
//    lazy var  model: Results<Purchase> = { self.realm.objects(Purchase.self) }()
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var selectAllLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sumPrice: UILabel!
    
    @IBAction func selectAllButtonTouch(_ sender: Any) {
        isAllSelected = !isAllSelected
        if isAllSelected {
            selectButton.setImage(UIImage(named: "selected"), for: .normal)
            
        }
        else {
            selectButton.setImage(UIImage(named: "nSelected"), for: .normal)
        }
        collectionView.reloadData()
    }
    @IBAction func payButtonTouch(_ sender: Any) {
    }
    // MARK: - Constants
    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 7
        static let spaceBetweenRows: CGFloat = 8
    }
    
    
    // MARK: - Lifeсyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        searchStatus()
        searchProductData()
        collectionView.reloadData()
        sumPrice.text = String(sum) + "0 p."
    }
   
}

// MARK: - Private Methods
private extension CartViewController {

    func searchProductData(){
        let products =  self.realm.objects(Purchase.self)
       
        for product in products {
            if product.user.login == currentUser.login && product.status.statusName == currentStatus.statusName {
                model.append(product)
                sum = sum + product.price*Double(product.count)
            }
        }
    }
    func searchStatus(){
        let statuses =  self.realm.objects(OrderStatus.self)
       
        for status in statuses {
            if status.statusName == "InCart"{
                currentStatus = status
                return
            }
        }
    }
    
    func configureApperance() {
        selectAllLabel.text = "Выбрать все"
        sumPrice.textColor = .black
        sumPrice.font = .systemFont(ofSize: 20)
        sumPrice.text = "0 р."

    
        navigationItem.title = "Корзина"
        
       
        collectionView.register(UINib(nibName: "\(CartCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(CartCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }

   
    
}

// MARK: - UICollection
extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CartCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? CartCollectionViewCell {
            let item = model[indexPath.row]
            cell.countText = item.count
            cell.priceText = item.price
            cell.titleText = item.product.productTitle
            cell.imageUrlInString = item.product.productPictureUrl
            //cell.imageUrlInString = item.imageUrlInString
            cell.select = isAllSelected
            
            }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = view.frame.width
        return CGSize(width: itemWidth, height: 0.3 * itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }

    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        navigationController?.pushViewController(DetailViewController(), animated: true)
//    }
    
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     super.prepare(for: segue, sender: sender)
     switch segue.identifier = ""
     let vc = segue.destination as? MainViewController
     */

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.model.productKey = model[indexPath.row].product.productKey
        vc.model.info = model[indexPath.row].product.productInfo
        vc.model.price = model[indexPath.row].product.productPrice
        vc.model.category = model[indexPath.row].product.category.name
        vc.model.provider = model[indexPath.row].product.provider.provaiderInfo
        vc.model.title = model[indexPath.row].product.productTitle
        vc.model.imageUrlInString = model[indexPath.row].product.productPictureUrl
        navigationController?.pushViewController(vc, animated: true)
    }

}


