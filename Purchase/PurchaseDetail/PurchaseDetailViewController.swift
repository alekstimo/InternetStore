//
//  PurchaseDetailViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 02.11.2022.
//

import UIKit
import RealmSwift

class PurchaseDetailViewController: UIViewController{

    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sumTextLabel: UILabel!
    @IBOutlet weak var statusTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var userTextLabel: UILabel!
    var array = [Purchase]()
    let realm = try! Realm()
    var date = NSDate()
    var sum = 0.0
    var user = User()
    let popVcStatus = PopOverStatus()
    
    
    @IBAction func statusButtonTapped(_ sender: Any) {
        guard currentUser.role == "admin" else { return }
        popVcStatus.modalPresentationStyle = .popover
        let popOverVc = popVcStatus.popoverPresentationController
        popOverVc?.delegate = self
        popOverVc?.sourceView = self.statusButton
        popOverVc?.sourceRect = CGRect(x: self.statusButton.bounds.midX , y: self.statusButton.bounds.maxY, width: 0, height: 0)
        popVcStatus.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(popVcStatus, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        configureAppearance()
        
        NotificationCenter.default.addObserver(self, selector: #selector(statusSelected), name: NSNotification.Name("statusSelected"), object: nil)
    }
    @objc func statusSelected(notification: NSNotification) {
        if let dict = notification.object
         as? NSDictionary{
            if let status = dict["status"] as? String{
                statusButton.setTitle(currentStatus(status: status), for: .normal)
                for elem in array {
                    try! realm.write() {
                        elem.status.statusName = status
                        self.realm.add(elem)
                    }
                    
                }
            }
        }
        
        //collectionView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        
        //searchUserData()
    }
    func setData(currentDate: NSDate, currentUser: User) {
        date = currentDate
        user = currentUser
    }
   
    func configureModel() {
        
        let purcahes =  self.realm.objects(Purchase.self)
       
        for purcahe in purcahes {
            if user.login == purcahe.user.login && purcahe.status.statusName != "InCart" && convertDate(date:purcahe.date) == convertDate(date:date){
                array.append(purcahe)
                sum += purcahe.price * Double(purcahe.count)
            }
        }
        
    }
    
    func convertDate(date: NSDate) ->String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormater.string(from: date as Date)
    }
   
    
}
extension PurchaseDetailViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
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
        userTextLabel.text = "Покупатель: " + user.login
        userTextLabel.font = .systemFont(ofSize: 15)
        
        dateTextLabel.text = "Заказ от " + convertDate(date: date)
        dateTextLabel.font = .systemFont(ofSize: 15)
        
        sumTextLabel.text = "Сумма " + String(sum) + "0 p."
        sumTextLabel.font = .systemFont(ofSize: 15)
        
        statusTextLabel.text = "Статус заказа: "
        statusTextLabel.font = .systemFont(ofSize: 15)
        
        statusButton.setTitle(currentStatus(status: array[0].status.statusName), for: .normal)
        //statusButton.titleLabel?.text = currentStatus(status: array[0].status.statusName)
        statusButton.titleLabel?.font = .systemFont(ofSize: 15)
        
        if currentUser.role != "admin" {
            statusButton.isEnabled = false
            statusButton.setTitleColor(.black, for: .disabled)
        }
    }
    func currentStatus(status: String) -> String {
        guard !array.isEmpty else {return " "}
        switch status {
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

