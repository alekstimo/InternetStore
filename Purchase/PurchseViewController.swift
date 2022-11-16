//
//  PurchseViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 02.11.2022.
//

import UIKit
import RealmSwift

struct ShortPurchase {
    var date = NSDate()
    var sum = 0.0
}

class PurchseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    var array = [ShortPurchase]()
    
    
    //private var user = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        configureModel()
        //searchUserData()
    }
    
   
    func configureModel() {
        
        let purcahes =  self.realm.objects(Purchase.self)
        let tmpLogin = UserSettings.userName ?? " "
        //let tmpPassword = UserSettings.password ?? " "
        for purcahe in purcahes {
            if tmpLogin == purcahe.user.login && purcahe.status.statusName != "InCart"{
                if array.isEmpty {
                    array.append(ShortPurchase(date:  purcahe.date, sum: purcahe.price))
                } else {
                    addToArray(date: purcahe.date, sum: purcahe.price)
                }
            }
        }
        
    }
    func addToArray(date: NSDate, sum: Double){
        for (i, elem) in array.enumerated() {
            if convertDate(date: elem.date) == convertDate(date: date) {
                array[i].sum = array[i].sum + sum
                return
            }
        }
        array.append(ShortPurchase(date: date, sum: sum))
    }
    func convertDate(date: NSDate) ->String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormater.string(from: date as Date)
    }
   
    
}

// MARK: - Private Methods
private extension PurchseViewController {

   
//    func searchUserData(){
//        let users =  self.realm.objects(User.self)
//        let tmpLogin = UserSettings.userName ?? " "
//        let tmpPassword = UserSettings.password ?? " "
//        for us in users {
//            if us.login == tmpLogin && us.password == tmpPassword {
//                user = currentUser
//                return
//            }
//        }
//    }
    
    func configureAppearance() {
        configureTableView()
    }

    func configureNavigationBar() {
        navigationItem.title = "Заказы"
        let backButton = UIBarButtonItem(image: resizeImage(image: UIImage(named: "backArrow")!, targetSize: CGSize.init(width: 32, height: 32)),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        
    }
   

    func configureTableView() {
       
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UINib(nibName: "\(PurchaseTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(PurchaseTableViewCell.self)")
        
        
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.separatorStyle = .none
    }

}

// MARK: - UITableViewDataSource
extension PurchseViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "\(PurchaseTableViewCell.self)")
    if let cell = cell as? PurchaseTableViewCell {
        cell.sum = String(array[indexPath.row].sum) + "0 р."
        cell.purcahesDate = convertDate(date:array[indexPath.row].date)
    }
         
    return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select")
        let vc = PurchaseDetailViewController()
        vc.setDate(currentDate: array[indexPath.row].date)
        navigationController?.pushViewController(vc, animated: true)
    }

}

