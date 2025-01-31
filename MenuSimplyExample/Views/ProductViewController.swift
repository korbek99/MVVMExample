//
//  ProductViewController.swift
//  MenuSimplyExample
//
//  Created by Jose David Bustos H on 28-09-17.
//
import UIKit

class ProductViewController: UIViewController {
    
    private let viewModel = ProductViewModel()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Products"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    lazy var tableView: UITableView = {
        let table: UITableView = .init()
        table.dataSource = self
        table.delegate = self
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        table.rowHeight = 200.0
        table.separatorColor = UIColor.orange
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let menuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 6
        return view
    }()
    
    var leadingConstraint: NSLayoutConstraint!
    var menuShowing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        setupUX()
        setupMenuView()
        setupNavigationBar()
        
        viewModel.filteredProducts = viewModel.products
        searchBar.delegate = self
    }

    func setupUX() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupMenuView() {
        view.addSubview(menuView)

        leadingConstraint = menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -200)
        
        NSLayoutConstraint.activate([
            leadingConstraint,
            menuView.topAnchor.constraint(equalTo: view.topAnchor),
            menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.tintColor = .white
        menuView.addSubview(profileImageView)

        let welcomeLabel = UILabel()
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.text = "Bienvenido"
        welcomeLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        welcomeLabel.textColor = .white
        menuView.addSubview(welcomeLabel)

        let navigateButton = UIButton(type: .system)
        navigateButton.translatesAutoresizingMaskIntoConstraints = false
        navigateButton.setTitle("Config", for: .normal)
        navigateButton.setTitleColor(.white, for: .normal)
        navigateButton.addTarget(self, action: #selector(navigateToNextScreen), for: .touchUpInside)
        menuView.addSubview(navigateButton)

        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 160),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            welcomeLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            welcomeLabel.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            
            navigateButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            navigateButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor)
        ])
    }
    
    func setupNavigationBar() {
        let menuImage = UIImage(systemName: "line.horizontal.3")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(menuAction))
    }

    @objc func menuAction() {
        leadingConstraint.constant = menuShowing ? -200 : 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        menuShowing.toggle()
    }
    
    @objc func navigateToNextScreen() {
        let nextViewController = ConfigViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let product = viewModel.product(at: indexPath.row)
        
        let itemNameLabel = UILabel()
        itemNameLabel.text = product.itemName
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(itemNameLabel)
        
        let descLabel = UILabel()
        descLabel.text = product.description
        descLabel.font = UIFont.systemFont(ofSize: 12)
        descLabel.textColor = .gray
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(descLabel)
        
        let photoImageView = UIImageView()
        photoImageView.image = UIImage(named: product.photo)
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20),
            photoImageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 150),
            photoImageView.heightAnchor.constraint(equalToConstant: 150),
            
            itemNameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 5),
            itemNameLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
            itemNameLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -10),

            descLabel.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor),
            descLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 5),
            descLabel.trailingAnchor.constraint(equalTo: itemNameLabel.trailingAnchor)
        ])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
  
        let detailsVC = DetailsViewController()
        
        let selectedProduct = viewModel.product(at: indexPath.row)
        detailsVC.strImage = selectedProduct.photo
        detailsVC.strLabel = selectedProduct.description

        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteProduct(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ProductViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterProducts(with: searchText)
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
