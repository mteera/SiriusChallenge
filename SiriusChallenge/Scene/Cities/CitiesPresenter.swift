//
//  CitiesPresenter.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.


import UIKit

protocol CitiesPresentationLogic {
  func presentSomething(response: City.Something.Response)
}

class CitiesPresenter: CitiesPresentationLogic {
  weak var viewController: CitiesDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: City.Something.Response) {
    let viewModel = City.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
