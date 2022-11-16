//
//  OptionsTableViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 02.11.2022.
//

import UIKit

class OptionsTableViewController: UITableViewController {
        
    
    
    let options = ["Заказы","Изменить профиль"]
    
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
            print("Изменить")
            break
        default:
            print("Err")
        }
    }
 
}

class TableViewCell: UITableViewCell {
    
}
