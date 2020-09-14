//  Created by douglas.nunes on 13/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapview = MKMapView()
        mapview.translatesAutoresizingMaskIntoConstraints = false
        return mapview
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.setTitle("Add", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.appColor(.snowManBlue)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addFavoriteSpot), for: .touchUpInside)
        return button
    }()
    
    private var locationManager: CLLocationManager?
    private let distanceSpan: Double = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        location()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupView() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
        mapView.addSubview(addButton)
        
        NSLayoutConstraint.activate([addButton.widthAnchor.constraint(equalToConstant: 60),
                                     addButton.heightAnchor.constraint(equalToConstant: 60),
                                     addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                     addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            
        ])
    }
    
    private func location() {
        locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
        mapView.showsUserLocation = true
        mapView.showsCompass = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func addFavoriteSpot() {
        showModal()
    }
    
    private func showModal() {
        Router.addSpotModal(view: self)
    }
}


extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                }
            }
        }
    }
}
