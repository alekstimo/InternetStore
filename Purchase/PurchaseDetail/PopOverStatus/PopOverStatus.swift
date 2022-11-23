//
//  PopOverStatus.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 23.11.2022.
//

import Foundation
import UIKit

class PopOverStatus: UIViewController {

   
    var statusTableView = UITableView()
    var statusArray = ["Framed","InDelivery","Compited"]

    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureCategoryTableView()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        preferredContentSize = CGSize(width: 250, height: statusTableView.contentSize.height)
    }
    func configureCategoryTableView() {
        
        view.addSubview(statusTableView)
        statusTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            statusTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            statusTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            statusTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        statusTableView.register(UINib(nibName: "\(PopOverStatusTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(PopOverStatusTableViewCell.self)")
        statusTableView.dataSource = self
        statusTableView.delegate = self
       
    }
    private func currentStatus(status: String) -> String {
        guard !statusArray.isEmpty else {return " "}
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
    
}
// MARK: - UITableViewDataSource
extension PopOverStatus: UITableViewDataSource,UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PopOverStatusTableViewCell.self)")
        if let cell = cell as? PopOverStatusTableViewCell {
            cell.text = currentStatus(status: statusArray[indexPath.row])
           
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("statusSelected"), object: ["status": statusArray[indexPath.row]])
    }

}

