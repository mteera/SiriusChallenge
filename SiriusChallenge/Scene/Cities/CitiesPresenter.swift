//
//  CitiesPresenter.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.


import UIKit

protocol CitiesPresentationLogic {
  func presentCities(response: Cities.InitialData.Response)
}

class CitiesPresenter: CitiesPresentationLogic {
    weak var viewController: CitiesDisplayLogic?
    
    // MARK: Do something
    
    func presentCities(response: Cities.InitialData.Response) {
        let viewModel = Cities.InitialData.ViewModel(cities: response.cities)
        viewController?.displayCities(viewModel: viewModel)
    }
}
