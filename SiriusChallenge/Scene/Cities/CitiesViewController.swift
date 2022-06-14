//
//  CitiesViewController.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.

import UIKit

protocol CitiesDisplayLogic: class {
    func displaySomething(viewModel: City.Something.ViewModel)
}

class CitiesViewController: UIViewController, CitiesDisplayLogic {
    var interactor: CitiesBusinessLogic?
    var router: (NSObjectProtocol & CitiesRoutingLogic & CitiesDataPassing)?
    
    // MARK: Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect.zero)
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        return searchBar
    }()
    
    
    // MARK: Setup 
    private func setup() {
        let viewController = self
        let interactor = CitiesInteractor()
        let presenter = CitiesPresenter()
        let router = CitiesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setupViews() {
        view.addSubview(tableView)
        
        navigationItem.titleView = searchBar
        
        tableView.anchor(view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .white
        setupViews()
    }
    
    func displaySomething(viewModel: City.Something.ViewModel) {
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "Hurzuf UA"
        cell.detailTextLabel?.text = "Lng: 34.283333  Lat: 4.549999"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToMap()
    }
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
