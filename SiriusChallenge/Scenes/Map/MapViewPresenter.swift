//
//  MapViewPresenter.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 16/6/22.
//

import Foundation

protocol MapViewPresentationLogic {
    func presentCity(response: MapView.InitialData.Response)
}

class MapViewPresenter: MapViewPresentationLogic {
    weak var viewController: MapViewController?
    func presentCity(response: MapView.InitialData.Response) {}
}


