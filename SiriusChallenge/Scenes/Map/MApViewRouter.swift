//
//  MApViewRouter.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 16/6/22.
//

import Foundation

protocol MapViewDataStore {
    var selectedCity: City? { get set }
}


@objc protocol MapViewRoutingLogic {
    func routeToMap()
}

class MapViewRouter {
    var viewController: MapViewController?
    var dataStore: MapViewDataStore?
}
