//
//  CategoryViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 03.10.2022.
//

import UIKit

class CategoryViewController: UIViewController {

    
    private var categoryModel: CategoryModel = .init()
    private var filtredModel: CategoryModel = .init()
    private var selectedCategoryText = ""
    var selectedCategory: Category!
    
    @IBOutlet weak var categoryTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        configureAppearance()
        
        categoryModel.loadCategory()
        filtredModel.loadCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        preferredContentSize = CGSize(width: 250, height: categoryTableView.contentSize.height)
    }
    func getSelectedCategory() -> String {
        return selectedCategoryText
    }
    func editText(text: String){
        categoryModel.loadCategory()
        filtredModel.items = []
        //searchingText = text
        if text == "" || text == " " {
            filtredModel.items = categoryModel.items
        }
        else {
            for item in categoryModel.items {
                if item.lowercased().contains(text.lowercased()) {
                    filtredModel.items.append(item)
                }
            }
        }
        categoryTableView.reloadData()
    }
    
    func configureAppearance() {
        configureCategoryTableView()
    }
    func configureModel() {
        categoryModel.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.categoryTableView.reloadData()
            }
        }
    }
    func configureCategoryTableView() {
        
        categoryTableView.translatesAutoresizingMaskIntoConstraints = false

        categoryTableView.register(UINib(nibName: "\(CategoryTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(CategoryTableViewCell.self)")
        categoryTableView.register(UINib(nibName: "\(CategoryAddTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(CategoryAddTableViewCell.self)")
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
       
    }

}

// MARK: - UITableViewDataSource
extension CategoryViewController: UITableViewDataSource,UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtredModel.items.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == filtredModel.items.count
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(CategoryAddTableViewCell.self)")
            return cell ?? UITableViewCell()
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(CategoryTableViewCell.self)")
            if let cell = cell as? CategoryTableViewCell {
                cell.categoryName.text = filtredModel.items[indexPath.row]
            }
            return cell ?? UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell =  categoryTableView.cellForRow(at: indexPath) as! CategoryTableViewCell
        selectedCategoryText = cell.categoryName.text ?? ""
        
        //print(selectedProviderText)
    }

}

