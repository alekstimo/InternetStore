//
//  ProfileViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func exitButtonTappet(_ sender: Any) {
        UserSettings.userName = ""
        UserSettings.password = ""
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let vc = TabBarUserConfigurator().configure()
        appDelegate.window?.rootViewController = vc
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
