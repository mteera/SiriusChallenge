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
        viewController?.navigationController?.pushViewController(MapViewController(), animated: true)
    }
    
}
