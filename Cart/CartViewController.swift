//
//  CartViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import UIKit
import RealmSwift

class CartViewController: UIViewController {
    
   
    let refreshControl = UIRefreshControl()
    let realm = try! Realm()
    var sum: Double = 0.0
    var isAllSelected: Bool = true
    var currentStatus = OrderStatus()
    var model: [Purchase] = []
    var selected: [Bool] = []
//    lazy var  model: Results<Purchase> = { self.realm.objects(Purchase.self) }()
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var selectAllLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sumPrice: UILabel!
    
    @IBAction func selectAllButtonTouch(_ sender: Any) {
        isAllSelected = !isAllSelected
        if isAllSelected {
            selectButton.setImage(UIImage(named: "selected"), for: .normal)
            var i=0
            sum = 0.0
            for _ in selected {
                selected[i] = true
                sum = sum + model[i].price * Double(model[i].count)
                i+=1
            }
            sumPrice.text = String(sum) + "0 р."
        }
        else {
            var i=0
            for _ in selected {
                selected[i] = false
                i+=1
                sum = 0.0
                sumPrice.text = String(sum) + "0 p."
            }
            selectButton.setImage(UIImage(named: "nSelected"), for: .normal)
        }
        collectionView.reloadData()
    }
    @IBAction func payButtonTouch(_ sender: Any) {
        let alert = UIAlertController(title: "Оплатить", message: "Оплатить покупку на \(sumPrice.text ?? " ")?", preferredStyle: UIAlertController.Style.alert)
        let actionUpgrade = UIAlertAction.init(title: "Да", style: .default, handler: { action in
            let statuses =  self.realm.objects(OrderStatus.self)
            var stat = OrderStatus()
            for status in statuses {
                if status.statusName == "Framed"{
                    stat = status
                }
            }
            for (i,product) in self.model.enumerated() {
                if self.selected[i] == true {
                    try! self.realm.write() {
                        product.date = NSDate()
                        product.status = stat
                        self.realm.add(product)
                    }
                }
            }
            self.searchProductData()
            self.collectionView.reloadData()
            self.sumPrice.text = String(self.sum) + "0 p."
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(actionUpgrade)
        self.present(alert, animated: true, completion: nil)
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
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)
        self.collectionView.alwaysBounceVertical = true
        NotificationCenter.default.addObserver(self, selector: #selector(reprice), name: NSNotification.Name("rePrice"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cangeSelect), name: NSNotification.Name("cangeSelect"), object: nil)
        sumPrice.text = String(sum) + "0 p."
    }
    
    @objc func cangeSelect(notification: NSNotification){
        if let dict = notification.object
         as? NSDictionary{
            if let select = dict["select"] as? Bool {
                if select {
                    if let price = dict["price"] as? Double {
                        sum = sum + price
                    }
                    if let product = dict["product"] as? Purchase {
                        var i = 0
                        for prod in model {
                            if prod == product {
                                selected[i] = true
                            }
                            i+=1
                        }
                    }
                }
                else {
                     if let price = dict["price"] as? Double {
                         sum = sum - price
                     }
                     if let product = dict["product"] as? Purchase {
                        var i = 0
                        for prod in model {
                            if prod == product {
                                selected[i] = false
                            }
                            i+=1
                        }
                     }
                }
            }
            sumPrice.text = String(sum) + "0 р."
            if selected.contains(false){
                //print(selected)
                isAllSelected = false
                selectButton.setImage(UIImage(named: "nSelected"), for: .normal)
            } else {
                isAllSelected = true
                selectButton.setImage(UIImage(named: "selected"), for: .normal)
            }
        }
    }
    
    @objc func reprice(notification: NSNotification) {
        if let dict = notification.object
         as? NSDictionary{
            if let price = dict["price"] as? Double{
                sum = sum + price
            }
            sumPrice.text = String(sum) + "0 р."
        }
        
        //collectionView.reloadData()
        
    }
   
}

// MARK: - Private Methods
private extension CartViewController {

    
    @objc func refresh(_sender: AnyObject){
        self.searchProductData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            print("refresh data")
            }
        self.refreshControl.endRefreshing()
        sum = 0.0
        self.collectionView.reloadData()
        isAllSelected = true
        selectButton.setImage(UIImage(named: "selected"), for: .normal)
        }
        
    
    func searchProductData(){
        let products =  self.realm.objects(Purchase.self)
        model = []
        selected = []
        for product in products {
            if product.user.login == currentUser.login && product.status.statusName == currentStatus.statusName {
                model.append(product)
                selected.append(true)
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
//            if isAllSelected {
//                cell.select = isAllSelected
//                selected[indexPath.row] = true
//            }
            cell.select = selected[indexPath.row]
            cell.productData = item
//            sum = sum + item.price*Double(item.count)
//            sumPrice.text = String(sum) + "0 p."
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


