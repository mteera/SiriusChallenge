//
//  MapViewController.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Properties
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    
    func setupViews() {
        view.addSubview(mapView)
        mapView.anchor(view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
}
