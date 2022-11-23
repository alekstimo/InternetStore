//
//  OptionsTableViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 02.11.2022.
//

import UIKit

class OptionsTableViewController: UITableViewController {
        
    
    
    let options = ["Заказы","Изменить профиль","Изменить пароль","Удалить аккаунт"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        preferredContentSize = CGSize(width: 250, height: tableView.contentSize.height)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return options.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",for: indexPath) as! TableViewCell
        
        cell.textLabel?.text = options[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            //print("Заказы")
            NotificationCenter.default.post(name: NSNotification.Name("purchaseTapped"),object: nil)
            break
        case 1:
            //print("Изменить")
            NotificationCenter.default.post(name: NSNotification.Name("editProfileTapped"),object: nil)
            break
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name("editPasswordTapped"),object: nil)
            break
        case 3:
            let alert = UIAlertController(title: "Внимание!", message: "Вы уверены что хотите удалить аккаунт? ", preferredStyle: UIAlertController.Style.alert)
            let actionUpgrade = UIAlertAction.init(title: "Да", style: .default, handler: { action in
                guard currentUser.role == "admin" else {
                    NotificationCenter.default.post(name: NSNotification.Name("deleteAccount"),object: nil)
                    return
                }
                let alert = UIAlertController(title: ":)", message: "Вы не можете удалить свой аккаун", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            })
            alert.addAction(actionUpgrade)
            alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        default:
            print("Err")
        }
    }
 
}

class TableViewCell: UITableViewCell {
    
}
