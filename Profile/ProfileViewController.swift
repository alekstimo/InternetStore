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
    let popVC =  OptionsTableViewController()
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var exitButton: UIButton!
    // MARK: - Views
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
      //  print(Realm.Configuration.defaultConfiguration.fileURL)
        super.viewDidLoad()
        configureAppearance()
        NotificationCenter.default.addObserver(self, selector: #selector(purchaseTapped), name: NSNotification.Name("purchaseTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editProfileTapped), name: NSNotification.Name("editProfileTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editPasswordTapped), name: NSNotification.Name("editPasswordTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteAccount), name: NSNotification.Name("deleteAccount"), object: nil)
        
        tableView.reloadData()
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
    @objc func purchaseTapped(){
        let vc = PurchseViewController()
        navigationController?.pushViewController(vc, animated: true)
        popVC.dismiss(animated: false)
    }
    @objc func deleteAccount(){
        UserSettings.userName = ""
        UserSettings.password = ""
        self.realm.beginWrite()
        self.realm.delete(currentUser)
        do {
            try! self.realm.commitWrite()
        }
        currentUser = User()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let vc = TabBarUserConfigurator().configure()
        appDelegate.window?.rootViewController = vc
    }
    @objc func editProfileTapped(){
        let vc = EditProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
        popVC.dismiss(animated: false)
        
    }
    @objc func editPasswordTapped(){
        let vc = EditPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
        popVC.dismiss(animated: false)
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
    
    @objc func refresh(_sender: AnyObject){
        searchUserData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            print("refresh data")
            }
        self.refreshControl.endRefreshing()
        tableView.reloadData()
    }
    func configureAppearance() {
        configureTableView()
        exitButton.layer.cornerRadius = 12
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }

    func configureNavigationBar() {
        navigationItem.title = "Профиль"
        let optionButton = UIBarButtonItem(image:resizeImage(image: UIImage(named: "plus")!, targetSize: CGSize.init(width: 32, height: 32)) ,
                                         style: .plain, target: self,
                                           action: #selector(self.optionButtonTapped))
        navigationItem.rightBarButtonItem = optionButton
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    @objc func optionButtonTapped(){
       // print("searchButtonTapped")
        popVC.modalPresentationStyle = .popover
        let popOverVc = popVC.popoverPresentationController
        popOverVc?.delegate = self
        popOverVc?.sourceView = self.view
        popOverVc?.sourceRect = CGRect(x: self.view.bounds.maxX, y: self.view.safeAreaInsets.bottom, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(popVC, animated: true)
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
extension ProfileViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
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

