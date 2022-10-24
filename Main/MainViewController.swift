//
//  MainViewController.swift
//  InternetStore
//
//
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Constants
    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 7
        static let spaceBetweenRows: CGFloat = 8
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let model: MainModel = .init()
    
    // MARK: - Lifeсyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        configureModel()
        model.loadPosts()
        
    }
    //MARK: - SearchButton
    
    
    @objc func searchButtonTapped(){
       // print("searchButtonTapped")
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

// MARK: - Private Methods
private extension MainViewController {

    func configureApperance() {
        navigationItem.title = "Главная"
        
        let searchButton = UIBarButtonItem(image:resizeImage(image: UIImage(named: "search")!, targetSize: CGSize.init(width: 32, height: 32)) ,
                                         style: .plain, target: self,
                                           action: #selector(self.searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.rightBarButtonItem?.tintColor = .black
        
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
    
}

// MARK: - UICollection
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            let item = model.items[indexPath.row]
            cell.priceText = String(item.price)
            cell.titleText = item.title
            cell.imageUrlInString = item.imageUrlInString
            //cell.imageUrlInString = item.imageUrlInString
            
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
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        navigationController?.pushViewController(DetailViewController(), animated: true)
//    }
    
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     super.prepare(for: segue, sender: sender)
     switch segue.identifier = ""
     let vc = segue.destination as? MainViewController
     */

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.model = model.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

