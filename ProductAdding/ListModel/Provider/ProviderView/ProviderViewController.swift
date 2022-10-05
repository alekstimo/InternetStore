//
//  ProviderViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 03.10.2022.
//

import UIKit

class ProviderViewController: UIViewController {

    @IBOutlet weak var providerTableView: UITableView!
    private var providerModel: ProviderModel = .init()
    private var filtredModel: ProviderModel = .init()
    
    var selectedProviderText = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        configureAppearance()
        
        providerModel.loadCategory()
        filtredModel.loadCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        preferredContentSize = CGSize(width: 250, height: providerTableView.contentSize.height)
    }
    func getSelectedProvider() -> String {
        return selectedProviderText
    }
    
    func editText(text: String){
        providerModel.loadCategory()
        filtredModel.items = []
        //searchingText = text
        if text == "" || text == " " {
            filtredModel.items = providerModel.items
        }
        else {
            for item in providerModel.items {
                if item.lowercased().contains(text.lowercased()) {
                    filtredModel.items.append(item)
                }
            }
        }
            providerTableView.reloadData()
    }
    
    func configureAppearance() {
        configureCategoryTableView()
    }
    func configureModel() {
        providerModel.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.providerTableView.reloadData()
            }
        }
    }
    func configureCategoryTableView() {
        
        providerTableView.translatesAutoresizingMaskIntoConstraints = false

        providerTableView.register(UINib(nibName: "\(ProviderTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(ProviderTableViewCell.self)")
        providerTableView.register(UINib(nibName: "\(ProviderAddTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(ProviderAddTableViewCell.self)")
        providerTableView.dataSource = self
        providerTableView.delegate = self
    }

}

// MARK: - UITableViewDataSource
extension ProviderViewController: UITableViewDataSource,UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtredModel.items.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == filtredModel.items.count
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProviderAddTableViewCell.self)")
            return cell ?? UITableViewCell()
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProviderTableViewCell.self)")
            if let cell = cell as? ProviderTableViewCell {
                cell.provider.text = filtredModel.items[indexPath.row]
            }
            return cell ?? UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell =  providerTableView.cellForRow(at: indexPath) as! ProviderTableViewCell
        selectedProviderText = cell.provider.text ?? ""
        //print(selectedProviderText)
    }

}
