//
//  DetailViewController.swift
//  InternetStore
//
//
//
import UIKit
import RealmSwift
class DetailViewController: UIViewController, UIGestureRecognizerDelegate {

    let realm = try! Realm()
    var currentProduct = Product()
    var currentStatus = OrderStatus()
    var productInCart = Purchase()
    // MARK: - Views
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    var model: DetailModel = .createDefault()
    
    
    @IBOutlet weak var addToCartButton: UIButton!
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        tableView.reloadData()
        searchProductData()
        searchStatus()
        addToCartButton.titleLabel?.text = "Добавить в корзину"
    }

    @IBAction func addToCart(_ sender: Any) {
        if checkInCart() {
            
            
            try! realm.write() {
               // prod.count = 1
                self.productInCart.count += 1
                self.realm.add(self.productInCart)
                addToCartButton.setTitle("В корзине \(productInCart.count) шт.", for: .normal)
            }
        }
        else {
            try! realm.write() {
                let product =  Purchase(value:[currentProduct,currentUser,currentStatus,1,currentProduct.productPrice,NSDate()])
                self.realm.add(product)
                let alert = UIAlertController(title: "Супер!", message: "Товар успешно добавлен в вашу корзину!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                addToCartButton.setTitle("В корзине 1 шт.", for: .normal)
                addToCartButton.backgroundColor = .gray
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    @objc func searchButtonTapped(){
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - Private Methods
private extension DetailViewController {
    func checkInCart()->Bool{
        let cart =  self.realm.objects(Purchase.self)
        for product in cart {
            if product.product.productKey == currentProduct.productKey && product.status.statusName == currentStatus.statusName && product.user.name == currentUser.name {
                productInCart = product
                return true
            }
        }
        return false
    }
    func searchProductData(){
        let products =  self.realm.objects(Product.self)
       
        for product in products {
            if product.productKey == model.productKey{
                currentProduct = product
                return
            }
        }
    }
    func searchStatus(){
        let statuses =  self.realm.objects(OrderStatus.self)
       
        for status in statuses {
            if status.statusName == "InCart"{
                currentStatus = status
                return
            }
        }
    }
    func configureAppearance() {
        configureTableView()
    }

    func configureNavigationBar() {
        navigationItem.title = model.title
        let backButton = UIBarButtonItem(image: resizeImage(image: UIImage(named: "backArrow")!, targetSize: CGSize.init(width: 32, height: 32)),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let searchButton = UIBarButtonItem(image:resizeImage(image: UIImage(named: "search")!, targetSize: CGSize.init(width: 32, height: 32)),
                                         style: .plain, target: self,
                                           action: #selector(self.searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    func configureTableView() {
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])

        tableView.register(UINib(nibName: "\(ImageDetailTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(ImageDetailTableViewCell.self)")
       
        tableView.register(UINib(nibName: "\(TitleDetailTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(TitleDetailTableViewCell.self)")
        
        tableView.register(UINib(nibName: "\(PriceDetailTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(PriceDetailTableViewCell.self)")
        
        tableView.register(UINib(nibName: "\(CategoryDetailTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(CategoryDetailTableViewCell.self)")
        
        tableView.register(UINib(nibName: "\(ProviderDetailTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(ProviderDetailTableViewCell.self)")
        
        tableView.register(UINib(nibName: "\(InfoDetailTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(InfoDetailTableViewCell.self)")
       
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageDetailTableViewCell.self)")
            if let cell = cell as? ImageDetailTableViewCell {
                cell.imageUrlInString = model.imageUrlInString
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TitleDetailTableViewCell.self)")
            if let cell = cell as? TitleDetailTableViewCell {
                cell.title = model.title
                
            }
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PriceDetailTableViewCell.self)")
            if let cell = cell as? PriceDetailTableViewCell {
                cell.price = String(model.price)
                cell.key = model.productKey
            }
            return cell ?? UITableViewCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(CategoryDetailTableViewCell.self)")
            if let cell = cell as? CategoryDetailTableViewCell {
                cell.category = model.category
            }
            return cell ?? UITableViewCell()
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProviderDetailTableViewCell.self)")
            if let cell = cell as? ProviderDetailTableViewCell {
                cell.provider = model.provider
            }
            return cell ?? UITableViewCell()
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(InfoDetailTableViewCell.self)")
            if let cell = cell as? InfoDetailTableViewCell {
                cell.text = model.info
            }
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }

}
