//
//  ProductAddingViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import UIKit
import RealmSwift
class ProductAddingViewController: UIViewController {
    

    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var key: UITextField!
    @IBOutlet weak var productTitle: UITextField!
    @IBOutlet weak var picture: UITextField!
    @IBOutlet weak var productInfo: UITextView!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var provider: UITextField!
    
    private var ptrKey = ""
    private var ptrProductTitle = ""
    private var ptrPicture = ""
    private var ptrProductInfo = ""
    private var ptrPrice = ""
    private var ptrCategory = ""
    private var ptrProvider = ""
    
    let popVcCategory = CategoryViewController()
    let popVcProvider = ProviderViewController()
    let realm = try! Realm()
    lazy var products: Results<Product> = { self.realm.objects(Product.self) }()
    //MARK: Кнопка добавления
    @IBAction func addButtonPushed(_ sender: Any) {
        if checkKey(products: products, key: key.text!) {
         try! realm.write() {
             let product =  Product(value:[key.text! ,
                                           productInfo.text!,
                                           productTitle.text!,
                                           picture.text!,
                                           selectedCategory(),
                                           selectedProvider(),
                                           Double(price.text!)!])
             let cat = selectedCategory()
             self.realm.add(product)
            }
        } //TODO: CATCH Not add
        else {
            let alert = UIAlertController(title: "Ошибка!", message: "Товар с таким ключом уже есть! \n Обновить данные этого товара? ", preferredStyle: UIAlertController.Style.alert)
            let actionUpgrade = UIAlertAction.init(title: "Да", style: .default, handler: { action in
                try! self.realm.write() {
                    
                    var product = Product()
                    for prod in self.products {
                        if prod.productKey == self.key.text {
                            product = prod
                        }
                    }
                    product.provider = self.selectedProvider()
                    product.category = self.selectedCategory()
                    product.productTitle =  self.productTitle.text!
                    product.productPrice = Double(self.price.text!)!
                    product.productInfo = self.productInfo.text!
                    product.productPictureUrl = self.picture.text!
                    
                    self.realm.add(product)
                    let alert = UIAlertController(title: "Супер!", message: "Товар успешно добавлен в базу!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            alert.addAction(actionUpgrade)
            alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "Супер!", message: "Товар успешно добавлен в базу!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        clearAllTextField()
    }
    
    
    func clearAllTextField(){
        for view in self.view.subviews {
            if let textField = view as? UITextField {
                textField.text = ""
            }
        }
        productInfo.text = ""
    }
    
    func checkKey(products: Results<Product>, key: String) -> Bool {
        for product in products {
            if product.productKey == key {
                return false
            }
        }
        return true
    }
    func editProduct(productKey: String, info: String, title: String, newCategory: String, newProvider: String, pictUrl: String, NewPrice: Double) {
        
        ptrKey = productKey
        ptrProductInfo = info
        ptrProductTitle = title
        ptrCategory = newCategory
        ptrProvider = newProvider
        ptrPicture = pictUrl
        ptrPrice = String(NewPrice)
        
        
    }
    func updateAddButtonState(){
        
        let keyText = key.text ?? ""
        let productTitleText = productTitle.text ?? ""
        let pictureText = picture.text ?? ""
        let productInfoText = productInfo.text ?? ""
        let priceText = price.text ?? ""
        //let categoryText = category.text ?? ""
        //let providerText = provider.text ?? ""
        let categorySelected = setCategory()
        let providerSelected  = setProvider()
        addButton.isEnabled = !keyText.isEmpty && !productTitleText.isEmpty && !pictureText.isEmpty && !productInfoText.isEmpty && !priceText.isEmpty && categorySelected && providerSelected
        
    }
    
    @IBAction func EditingDidEnd(_ sender: Any) {
        updateAddButtonState()
        if !(price.text?.isEmpty ?? false) {
            //price.text = separatedNumber(price.text!)
        }
    }
    
    //MARK: Category events
    @IBAction func categoryEditing(_ sender: Any) {
        popVcCategory.editText(text: category.text ?? "")
        //updateAddButtonState()
    }
   
    
    
    @IBAction func categoryEditingDidBegin(_ sender: Any) {
        popVcCategory.modalPresentationStyle = .popover
        let popOverVc = popVcCategory.popoverPresentationController
        popOverVc?.delegate = self
        popOverVc?.sourceView = self.category
        popOverVc?.sourceRect = CGRect(x: self.category.bounds.midX , y: self.category.bounds.minY, width: 0, height: 0)
        popVcCategory.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(popVcCategory, animated: true)
    }
    
    func setCategory() ->Bool {
        let cat = popVcCategory.getSelectedCategory()
        if cat != "" && !cat.isEmpty {
            category.text = cat
            return true
        }
        return false
    }
    func selectedCategory() -> Category {
        let categories = self.realm.objects(Category.self)
        for cat in categories {
            if cat.name == category.text! {
                return cat
            }
        }
        return Category()
    }
    //MARK: Provider events
    @IBAction func providerEditing(_ sender: Any) {
        popVcProvider.editText(text: provider.text ?? "")
        
    }
    
    
    @IBAction func providerEditingDidBegin(_ sender: Any) {
        popVcProvider.modalPresentationStyle = .popover
        let popOverVc = popVcProvider.popoverPresentationController
        popOverVc?.delegate = self
        popOverVc?.sourceView = self.provider
        popOverVc?.sourceRect = CGRect(x: self.provider.bounds.midX , y: self.provider.bounds.minY, width: 0, height: 0)
        popVcProvider.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(popVcProvider, animated: true)
        
    }
    func setProvider() -> Bool {
        let prov = popVcProvider.getSelectedProvider()
        if  prov != "" {
            provider.text = prov

            return true
        }
        return false
    }
    func selectedProvider() -> Provider {
        let providers = self.realm.objects(Provider.self)
        for prov in providers {
            if prov.provaiderInfo == provider.text! {
                return prov
            }
        }
        return Provider()
    }
    
    //MARK: Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        addButton.layer.cornerRadius = 12
        addButton.isEnabled = false
        key.delegate  = self
        if !ptrKey.isEmpty {
            key.text = ptrKey
            productInfo.text = ptrProductInfo
            productTitle.text = ptrProductTitle
            category.text = ptrCategory
            provider.text = ptrProvider
            picture.text = ptrPicture
            price.text = ptrPrice
        }
    }
    
   
    
}

//MARK: Private methods

private extension ProductAddingViewController {
    

    func configureNavigationBar() {
        navigationItem.title = "Добавление товара"
    }

}
extension ProductAddingViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

//MARK: TextField
extension ProductAddingViewController: UITextFieldDelegate {
    
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if textField == key {
           let allowedCharacters = CharacterSet(charactersIn:"0123456789")
           let characterSet = CharacterSet(charactersIn: string)
           return allowedCharacters.isSuperset(of: characterSet)
       }
       return true
   }
    
    //TODO: Форматирование цены
}
