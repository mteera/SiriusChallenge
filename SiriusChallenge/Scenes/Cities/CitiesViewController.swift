//
//  CitiesViewController.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.

import UIKit

protocol CitiesDisplayLogic: class {
    func displayCities(viewModel: Cities.InitialData.ViewModel)
    func displayFilteredCities(viewModel: Cities.InitialData.ViewModel)
    func displayCityDetails()
}

class CitiesViewController: UIViewController, CitiesDisplayLogic {
    var interactor: CitiesBusinessLogic?
    var router: (CitiesRoutingLogic & CitiesDataPassing)?
    var filteredCitites: [City] = []
    var allCitites: [City] = []

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
        tableView.showActivityIndicator()
    }
        
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .white
        setupViews()
        initialData()
    }
    
    func initialData() {
        let request = Cities.InitialData.Request()
        interactor?.initialData(request: request)
    }
    
    func displayCities(viewModel: Cities.InitialData.ViewModel) {
        self.allCitites = viewModel.cities
        self.filteredCitites = viewModel.cities
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func displayFilteredCities(viewModel: Cities.InitialData.ViewModel) {
        self.filteredCitites = viewModel.cities
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    func displayCityDetails() {
        router?.routeToMap()
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let city = filteredCitites[indexPath.row]
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = "Lon: \(city.coord.lon)  Lat: \(city.coord.lat)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCitites.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = filteredCitites[indexPath.row]
        interactor?.select(city)
    }
    
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCitites = allCitites
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            return
        }
        interactor?.searchFor(searchText)
    }
}


extension UITableView {
    func showActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            let activityView = UIActivityIndicatorView(style: .medium)
            self?.backgroundView = activityView
            activityView.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundView = nil
        }
    }
}
