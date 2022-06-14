//
//  CitiesRouter.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.

import UIKit

@objc protocol CitiesRoutingLogic {
  func routeToMap()
}

protocol CitiesDataPassing {
  var dataStore: CitiesDataStore? { get }
}

class CitiesRouter: NSObject, CitiesRoutingLogic, CitiesDataPassing {

  weak var viewController: CitiesViewController?
  var dataStore: CitiesDataStore?
  
  // MARK: Routing
    func routeToMap() {
        let destinationVC = MapViewController()
        if let dataStore = dataStore, let selectedCity = dataStore.selectedCity {
            let viewModel = MapView.InitialData.ViewModel(city: selectedCity)
            destinationVC.configure(viewModel: viewModel)
            viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    func passDataToMap(source: CitiesDataStore, destination: inout MapViewDataStore) {
        destination.selectedCity = source.selectedCity
    }
    
}
