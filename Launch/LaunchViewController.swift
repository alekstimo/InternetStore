//
//  LaunchViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import UIKit
import RealmSwift

class LaunchViewController: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm()
    lazy var users: Results<User> = { self.realm.objects(User.self) }()
    
    @IBOutlet weak var adminButton: UIButton!
    @IBOutlet weak var userButton: UIButton!
    
    @IBOutlet weak var EnterButton: UIButton!
    
    @IBOutlet weak var RegisterButton: UIButton!
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    let buttonImageShowPas = UIImage(named: "show")
    let buttonImageDntShowPas = UIImage(named: "dntShow")
    let button = UIButton(type: .custom)
    @objc func showPasswordButtonTapped(_ sender: Any) {
        
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        if passwordTextField.isSecureTextEntry {
            button.setImage(buttonImageDntShowPas, for: .normal)
        }
        else {
            button.setImage(buttonImageShowPas, for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EnterButton.layer.cornerRadius = 12
        RegisterButton.layer.cornerRadius = 12
        loginTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    //TODO: Нажатие кнопки войти и регистрации (переход на экран регистрации)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adminButton.titleLabel?.text = "Админ"
        
        if users.count == 0 {
            try! realm.write() {
             
                let defaultAdmin = User(value: ["admin", "1234","ул. Пушкина дом Колотушкина 5", "Бедная Лиза", "79203335674","https://static.life.ru/publications/2020/11/23/867708535470.403-900x.jpeg","admin"])
                self.realm.add(defaultAdmin)
            }
        }
        configure()
    }
    private func configure() {
           // loginTextField.shouldChangeText(in: , replacementText: String)
           
            
            loginTextField.clipsToBounds = true
            loginTextField.layer.cornerRadius = 10
            loginTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            passwordTextField.clipsToBounds = true
            passwordTextField.layer.cornerRadius = 10
            passwordTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            
            passwordTextField.setBottomBorderOnlyWith(color: UIColor.lightGray.cgColor)
            loginTextField.setBottomBorderOnlyWith(color: UIColor.lightGray.cgColor)
            
            loginTextField.indent(size: 10)
            passwordTextField.indent(size: 10)
        
            button.setImage(buttonImageDntShowPas, for: .normal)
            button.tintColor = .lightGray
            button.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
            // Assign the overlay button to the text field
            passwordTextField.rightView = button
            passwordTextField.rightViewMode = .whileEditing
            passwordTextField.isSecureTextEntry = true
            
        }
    
    
    @IBAction func SignUpButtonPushed(_ sender: Any) {
        let vc = SignUpViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: Sing in button pushed
    @IBAction func singInButtonPushed(_ sender: Any) {
        if let login = loginTextField.text{
            if let password = passwordTextField.text{
                if(login.isEmpty) {
                    loginTextField.isError(baseColor: UIColor.gray.cgColor)
                    if (password.isEmpty){
                        passwordTextField.isError(baseColor: UIColor.gray.cgColor)
                        return
                    }
                }
                if (password.isEmpty){
                    passwordTextField.isError(baseColor: UIColor.gray.cgColor)
                    return
                }
                for user in users {
                    if user.login == login && user.password == password {
                        UserSettings.userName = login
                        UserSettings.password = password
                        if user.role == "admin"{
                            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                            let vc = TabBarAdminConfigurator().configure()
                            appDelegate.window?.rootViewController = vc
                        }
                        else {
                            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                            let vc = TabBarUserConfigurator().configure()
                            appDelegate.window?.rootViewController = vc
                        }
                    }
                    //TODO: ВСПЛЫВ ОШИБКИ
                    passwordTextField.isError(baseColor: UIColor.gray.cgColor)
                    loginTextField.isError(baseColor: UIColor.gray.cgColor)
                }
            } else {
                passwordTextField.isError(baseColor: UIColor.gray.cgColor)
            }
        }
        else {
            loginTextField.isError(baseColor: UIColor.gray.cgColor)
        }
        
        
        
    }
    @IBAction func userButtonTapped(_ sender: Any) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let vc = TabBarUserConfigurator().configure()
        appDelegate.window?.rootViewController = vc
    }
    
    @IBAction func adminButtonTapped(_ sender: Any) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let vc = TabBarAdminConfigurator().configure()
        appDelegate.window?.rootViewController = vc
    }
    
}


//MARK: TextField
extension UITextField {
    func setBottomBorderOnlyWith(color: CGColor) {
        self.borderStyle = .none
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func isError(baseColor: CGColor) {
//        let errorText = UILabel()
//        errorText.text = "Поле не может быть пустым"
//        errorText.textColor = .red
//        errorText.font = .systemFont(ofSize: 12)
//        errorText.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 15)
//        errorText.topAnchor.constraint(equalTo:
//        self.bottomAnchor, constant: -15).isActive = true
//        errorText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        //TODO: - Доделать ошибку
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration =  1.0
        
        self.layer.add(animation, forKey: "")
    }
    
    func indent(size:CGFloat) {
           self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
           self.leftViewMode = .always
       }
}
