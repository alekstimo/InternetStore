//
//  EditPasswordViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 22.11.2022.
//

import UIKit
import RealmSwift
class EditPasswordViewController: UIViewController {

    
    
    @IBOutlet weak var updateButton: UIButton!
   
    @IBOutlet weak var oldPassword: UITextField!

    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var newPasswordRepeat: UITextField!
    
    let buttonImageShowPas = UIImage(named: "show")
    let buttonImageDntShowPas = UIImage(named: "dntShow")
    let button = UIButton(type: .custom)
    @objc func showPasswordButtonTapped(_ sender: Any) {
        
        oldPassword.isSecureTextEntry = !oldPassword.isSecureTextEntry
        if oldPassword.isSecureTextEntry {
            button.setImage(buttonImageDntShowPas, for: .normal)
        }
        else {
            button.setImage(buttonImageShowPas, for: .normal)
        }
    }
   
   let realm = try! Realm()
//    lazy var users: Results<User> = { self.realm.objects(User.self) }()
    
    @IBAction func addButtonPushed(_ sender: Any) {
        guard isAllField() else {
            let alert = UIAlertController(title: "Ошибка!", message: "Поля не должны быть пустыми!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if oldPassword.text! == currentUser.password {
            if newPassword.text! == newPasswordRepeat.text! {
                let alert = UIAlertController(title: "Внимание!", message: "Вы уверены что хотите обновить пароль? ", preferredStyle: UIAlertController.Style.alert)
                let actionUpgrade = UIAlertAction.init(title: "Да", style: .default, handler: { action in
                    try! self.realm.write() {
                        
                        
                        currentUser.password = self.newPassword.text!
                        self.realm.add(currentUser)
                        let alert = UIAlertController(title: "Супер!", message: "Вы успешно обновили пароль!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.dismiss(animated: true)
                    }
                })
                alert.addAction(actionUpgrade)
                alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
                
            } else {
                let alert = UIAlertController(title: "Ошибка!", message: "Пароли не совпадают!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Ошибка!", message: "Неправильный старый пароль!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //MARK: Кнопка обновления
    
    
    private func isAllField() -> Bool {
        if oldPassword.hasText && newPassword.hasText &&  newPasswordRepeat.hasText {
            return true
        }
        return false
    }

   
    
    //MARK: Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        updateButton.layer.cornerRadius = 12
        
    }
    
   
    
}

//MARK: Private methods

private extension EditPasswordViewController {
    

    func configureNavigationBar() {
        navigationItem.title = "Изменить пароль"
        let backButton = UIBarButtonItem(image: resizeImage(image: UIImage(named: "backArrow")!, targetSize: CGSize.init(width: 32, height: 32)),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        button.setImage(buttonImageDntShowPas, for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        
        oldPassword.rightView = button
        oldPassword.rightViewMode = .whileEditing
        oldPassword.isSecureTextEntry = true
        
        newPassword.isSecureTextEntry = true
        newPasswordRepeat.isSecureTextEntry = true
    }

}
