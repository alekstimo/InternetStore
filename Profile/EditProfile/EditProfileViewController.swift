//
//  EditProfileViewController.swift
//  InternetStore
//
//
//

import UIKit
import RealmSwift

class EditProfileViewController: UIViewController {
    
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var picture: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var telephone: UITextField!
    @IBOutlet weak var adress: UITextField!
    
    
    
   
    let realm = try! Realm()
    lazy var users: Results<User> = { self.realm.objects(User.self) }()
    
    //MARK: Кнопка обновления
    @IBAction func addButtonPushed(_ sender: Any) {
        if isLoginFree(users: users, login: login.text!) {
            let alert = UIAlertController(title: "Внимание!", message: "Вы уверены что хотите обновить данные? ", preferredStyle: UIAlertController.Style.alert)
            let actionUpgrade = UIAlertAction.init(title: "Да", style: .default, handler: { action in
                try! self.realm.write() {
                    
                    
                    currentUser.login = self.login.text!
                    currentUser.name = self.name.text!
                    currentUser.adress = self.adress.text!
                    currentUser.photoUrl = self.picture.text!
                    currentUser.telephone = self.telephone.text!
                    
                    
                    
                    self.realm.add(currentUser)
                    let alert = UIAlertController(title: "Супер!", message: "Вы успешно обновили свои данные!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            })
            alert.addAction(actionUpgrade)
            alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        } else {
            let alert = UIAlertController(title: "Ошибка!", message: "Такой логин уже занят!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       
        
    }
    
    
    
    func isLoginFree(users: Results<User>, login: String) -> Bool {
        for user in users {
            if user.login == login && currentUser.login != login {
                return false
            }
        }
        return true
    }
//    func editProduct(productKey: String, info: String, title: String, newCategory: String, newProvider: String, pictUrl: String, NewPrice: Double) {
//
//        ptrKey = productKey
//        ptrProductInfo = info
//        ptrProductTitle = title
//        ptrCategory = newCategory
//        ptrProvider = newProvider
//        ptrPicture = pictUrl
//        ptrPrice = String(NewPrice)
//
//
//    }
//    func updateAddButtonState(){
//
//        let keyText = key.text ?? ""
//        let productTitleText = productTitle.text ?? ""
//        let pictureText = picture.text ?? ""
//        let productInfoText = productInfo.text ?? ""
//        let priceText = price.text ?? ""
//        //let categoryText = category.text ?? ""
//        //let providerText = provider.text ?? ""
//
//        addButton.isEnabled = !keyText.isEmpty && !productTitleText.isEmpty && !pictureText.isEmpty && !productInfoText.isEmpty && !priceText.isEmpty
//
//    }
//
//    @IBAction func EditingDidEnd(_ sender: Any) {
//        updateAddButtonState()
//        if !(price.text?.isEmpty ?? false) {
//            //price.text = separatedNumber(price.text!)
//        }
//    }
    
   
   
    
    //MARK: Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        updateButton.layer.cornerRadius = 12
        login.text = currentUser.login
        name.text = currentUser.name
        adress.text = currentUser.adress
        telephone.text = currentUser.telephone
        picture.text = currentUser.photoUrl
    }
    
   
    
}

//MARK: Private methods

private extension EditProfileViewController {
    

    func configureNavigationBar() {
        navigationItem.title = "Изменить"
        let backButton = UIBarButtonItem(image: resizeImage(image: UIImage(named: "backArrow")!, targetSize: CGSize.init(width: 32, height: 32)),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

}


//MARK: TextField
extension EditProfileViewController: UITextFieldDelegate {
    
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if textField == telephone {
           let allowedCharacters = CharacterSet(charactersIn:"0123456789")
           let characterSet = CharacterSet(charactersIn: string)
           return allowedCharacters.isSuperset(of: characterSet)
       }
       return true
   }
    
    //TODO: Форматирование телефона
}
