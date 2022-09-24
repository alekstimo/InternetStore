//
//  LaunchViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var adminButton: UIButton!
    @IBOutlet weak var userButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adminButton.titleLabel?.text = "Администратор"
        //adminButton.titleLabel?.text.size = 20
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
