//
//  SearchViewController.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 12.10.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate, UISearchBarDelegate {

    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 7
        static let spaceBetweenRows: CGFloat = 8
    }
    private var searchBar: UISearchBar = UISearchBar()
    private var filtredModel: MainModel = .init()
    private var model: MainModel = .init() //Для избранного???
    
    
    @IBOutlet var emptyView: UIView!
 
   
    @IBOutlet var nothingFoundView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        configureApperance()
        configureModel()
        
        emptyView.frame = self.view.frame
        self.view.addSubview(emptyView)
       
        model.loadPosts()
        filtredModel.loadPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
        
    }
    
    //MARK: -  SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtredModel.items = []
        if searchText == "" {
            emptyView.frame = self.view.frame
            self.view.addSubview(emptyView)
        } else {
            
            nothingFoundView.removeFromSuperview()
            emptyView.removeFromSuperview()
            for item in model.items {
                
                if item.title.lowercased().contains(searchText.lowercased()) {
                    filtredModel.items.append(item)
                }
                
            }
            if filtredModel.items.isEmpty {
                nothingFoundView.frame = self.view.frame
                self.view.addSubview(nothingFoundView)
            }
        }
        
        
        
        self.collectionView.reloadData()
        
    }

    

}

  




//MARK: - Private Methods
private extension SearchViewController {
    
    func configureApperance() {
        collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        
       
    }
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: resizeImage(image: UIImage(named: "backArrow")!, targetSize: CGSize.init(width: 32, height: 32)),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        searchBar.sizeToFit()
        customSearchBar()
        searchBar.placeholder = "Поиск"
        navigationItem.titleView = searchBar
        
        
    }
    func customSearchBar(){
        
        let searchField = searchBar.value(forKey: "searchField") as? UITextField

            if let field = searchField {
                field.layer.cornerRadius = 22
                field.textColor = .black
                field.tintColor = .black

                field.font = UIFont.systemFont(ofSize: 14)
                field.layer.masksToBounds = true
                field.returnKeyType = .search
            }
        
      
    }
    
}



// MARK: - UICollection

extension SearchViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtredModel.items.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            let item = filtredModel.items[indexPath.row]
            cell.priceText = String(item.price)
            cell.titleText = item.title
            cell.imageUrlInString = item.imageUrlInString
            
            }
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.horisontalInset * 2 - Constants.spaceBetweenElements) / 2
        return CGSize(width: itemWidth, height: 1.7 * itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenElements
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.model = filtredModel.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
