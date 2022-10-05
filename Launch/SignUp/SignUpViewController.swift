//
//  SignUpViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 03.10.2022.
//

import UIKit
import RealmSwift
class SignUpViewController: UIViewController {
    
    let realm = try! Realm()
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var adress: UITextField!
    
    @IBOutlet weak var telephone: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var photo: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSignInButtonState()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    func configure(){
        signInButton.layer.cornerRadius = 12
        
    }
    func updateSignInButtonState(){
        
        let nameText = name.text ?? ""
        let adressText = adress.text ?? ""
        let telephoneText = telephone.text ?? ""
        let passwordText = password.text ?? ""
        let photoText = photo.text ?? ""
        let loginText = login.text ?? ""
        
        signInButton.isEnabled = !nameText.isEmpty && !adressText.isEmpty && !telephoneText.isEmpty && !passwordText.isEmpty && !photoText.isEmpty && !loginText.isEmpty
        
    }
    @IBAction func textEditingChange(_ sender: Any) {
        updateSignInButtonState()
    }
    
    
    @IBAction func signInButtonPushed(_ sender: Any) {
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        try! realm.write() {
            let user =  User(value:[login.text,password.text,adress.text,name.text,telephone.text,photo.text])
            self.realm.add(user)
            UserSettings.userName = login.text
            UserSettings.password = password.text
            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
            let vc = TabBarUserConfigurator().configure()
            appDelegate.window?.rootViewController = vc
        }
        
        
    }
    
  

}
