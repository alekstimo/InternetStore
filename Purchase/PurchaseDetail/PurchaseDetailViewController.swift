//
//  PurchaseDetailViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 02.11.2022.
//

import UIKit
import RealmSwift

class PurchaseDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sumTextLabel: UILabel!
    @IBOutlet weak var statusTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    var array = [Purchase]()
    let realm = try! Realm()
    var date = NSDate()
    var sum = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        configureAppearance()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        
        //searchUserData()
    }
    func setDate(currentDate: NSDate) {
        date = currentDate
    }
   
    func configureModel() {
        
        let purcahes =  self.realm.objects(Purchase.self)
        let tmpLogin = UserSettings.userName ?? " "
        //let tmpPassword = UserSettings.password ?? " "
        for purcahe in purcahes {
            if tmpLogin == purcahe.user.login && purcahe.status.statusName != "InCart" && convertDate(date:purcahe.date) == convertDate(date:date){
                array.append(purcahe)
                sum += purcahe.price
            }
        }
        
    }
    
    func convertDate(date: NSDate) ->String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormater.string(from: date as Date)
    }
   
    
}

// MARK: - Private Methods
private extension PurchaseDetailViewController {

   
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
        dateTextLabel.text = "Заказ от " + convertDate(date: date)
        dateTextLabel.font = .systemFont(ofSize: 15)
        
        sumTextLabel.text = "Сумма " + String(sum) + "0 p."
        sumTextLabel.font = .systemFont(ofSize: 15)
        
        statusTextLabel.text = "Статус заказа: " + currentStatus()
        statusTextLabel.font = .systemFont(ofSize: 15)
    }
    func currentStatus() -> String {
        guard !array.isEmpty else {return " "}
        switch array[0].status.statusName {
        case "Framed":
            return "Зарегистрирован"
        case "InDelivery":
            return "В доставке"
        case "Compited":
            return "Завершен"
        default:
            return "Error"
        }
    }
    func configureNavigationBar() {
        navigationItem.title = "Детали заказа"
        let backButton = UIBarButtonItem(image: resizeImage(image: UIImage(named: "backArrow")!, targetSize: CGSize.init(width: 32, height: 32)),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        
    }
   

    func configureTableView() {
       
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UINib(nibName: "\(DetailPurchaseTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DetailPurchaseTableViewCell.self)")
        
        
        tableView.dataSource = self
        //tableView.separatorStyle = .none
    }

}

// MARK: - UITableViewDataSource
extension PurchaseDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailPurchaseTableViewCell.self)")
    if let cell = cell as? DetailPurchaseTableViewCell {
        //cell.sum = String(array[indexPath.row].sum) + "0 р."
        //cell.purcahesDate = array[indexPath.row].date
        cell.countText = array[indexPath.row].count
        cell.title = array[indexPath.row].product.productTitle
        cell.imageUrlInString = array[indexPath.row].product.productPictureUrl
       // print(array[indexPath.row].product.productPrice)
        cell.priceText = array[indexPath.row].product.productPrice
    }
         
    return cell ?? UITableViewCell()
    }
    

}

