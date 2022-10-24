//
//  ProfileViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import UIKit
import RealmSwift
class ProfileViewController: UIViewController {
    let realm = try! Realm()
    
    private var user = User()
    
    // MARK: - Views
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        searchUserData()
    }
    
    
    @IBAction func exitButtonTappet(_ sender: Any) {
        currentUser = User()
        UserSettings.userName = ""
        UserSettings.password = ""
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let vc = TabBarUserConfigurator().configure()
        appDelegate.window?.rootViewController = vc
    }
    
    
}

// MARK: - Private Methods
private extension ProfileViewController {

    func format(phoneNumber: String) -> String {
        let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
        
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options:[], range: range, withTemplate: "")
        
        
        
        
        let maxIndex = number.index(number.startIndex,offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
        number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3 $4 $5",options: .regularExpression,range: regRange)
        
        return "+" + number
    }
    
    func searchUserData(){
        let users =  self.realm.objects(User.self)
        let tmpLogin = UserSettings.userName ?? " "
        let tmpPassword = UserSettings.password ?? " "
        for us in users {
            if us.login == tmpLogin && us.password == tmpPassword {
                user = currentUser
                return
            }
        }
    }
    
    func configureAppearance() {
        configureTableView()
    }

    func configureNavigationBar() {
        navigationItem.title = "Профиль"
    }

    func configureTableView() {
       
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UINib(nibName: "\(ProfileImageTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(ProfileImageTableViewCell.self)")
       
        tableView.register(UINib(nibName: "\(ProfileNameTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(ProfileNameTableViewCell.self)")
        
        tableView.register(UINib(nibName: "\(ProfileAdressTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(ProfileAdressTableViewCell.self)")
        
        tableView.register(UINib(nibName: "\(ProfileTelephoneTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(ProfileTelephoneTableViewCell.self)")
        
        
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileImageTableViewCell.self)")
            if let cell = cell as? ProfileImageTableViewCell {
                cell.imageUrlInString = user.photoUrl
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileNameTableViewCell.self)")
            if let cell = cell as? ProfileNameTableViewCell {
                cell.name = user.name
                
            }
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileAdressTableViewCell.self)")
            if let cell = cell as? ProfileAdressTableViewCell {
                cell.adress = user.adress
            }
            return cell ?? UITableViewCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileTelephoneTableViewCell.self)")
            if let cell = cell as? ProfileTelephoneTableViewCell {
                cell.telephone = format(phoneNumber: user.telephone)
            }
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }

}

