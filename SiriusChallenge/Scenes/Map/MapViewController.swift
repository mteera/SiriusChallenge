//
//  MapViewController.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.
//

import UIKit
import MapKit

protocol MapViewDisplayLogic {}

class MapViewController: UIViewController {
    var interactor: MapViewInteractor?
    var router: (MapViewRoutingLogic & MapViewDataPassing)?
    var viewModel: MapView.InitialData.ViewModel?
    // MARK: - Properties
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        setupViews()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = MapViewInteractor()
        let presenter = MapViewPresenter()
        let router = MapViewRouter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
       
    }
    
    func configure(viewModel: MapView.InitialData.ViewModel) {
        self.viewModel = viewModel
        let selectedCityAnnotation = MKPointAnnotation()
        title = "\(viewModel.city.name), \(viewModel.city.country)"
        selectedCityAnnotation.title = "\(viewModel.city.name), \(viewModel.city.country)"
        selectedCityAnnotation.coordinate = CLLocationCoordinate2D(latitude: viewModel.city.coord.lat, longitude: viewModel.city.coord.lon)
        mapView.addAnnotation(selectedCityAnnotation)
        zoomOnMapAnnotation(lat: viewModel.city.coord.lat, lon: viewModel.city.coord.lon)
    }
 
    func setupViews() {
        view.addSubview(mapView)
        mapView.anchor(view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    private func zoomOnMapAnnotation(lat: Double, lon: Double) {
        let cityLocation = CLLocation(latitude: lat, longitude: lon)
        let cityRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: cityLocation.coordinate.latitude, longitude: cityLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(cityRegion, animated: true)
    }
    
}







