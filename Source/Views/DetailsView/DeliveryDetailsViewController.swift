//
//  DeliveryDetailsViewController.swift
//  DeliveryDetails
//
//  Created by Aatish Molasi on 2/24/19.
//  Copyright © 2019 Aatish Molasi. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController, ViewSetupProtocol {

    var deliveryMapView: MKMapView
    var deliveryView: DeliveryView

    var delivery:Delivery

    init(delivery: Delivery) {
        deliveryMapView = MKMapView(frame: .zero)
        deliveryView = DeliveryView()
        self.delivery = delivery
        super.init(nibName: nil, bundle: nil)

        deliveryView.updateData(delivery: delivery)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupViews() {
        self.view.addSubview(deliveryMapView)
        self.view.addSubview(deliveryView)
    }

    func setupAppearance() {
        self.view.backgroundColor = UIColor.white
    }

    func setupConstraints() {
        deliveryMapView.translatesAutoresizingMaskIntoConstraints = false
        deliveryView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deliveryMapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            deliveryMapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            deliveryMapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            deliveryMapView.bottomAnchor.constraint(equalTo: deliveryView.topAnchor, constant: -10),
            ]);

        NSLayoutConstraint.activate([
            deliveryView.leadingAnchor.constraint(equalTo: deliveryMapView.leadingAnchor, constant: 0),
            deliveryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            deliveryView.trailingAnchor.constraint(equalTo: deliveryMapView.trailingAnchor, constant: 0),
            ]);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateMap()
    }

    private func customSetup(){
        deliveryMapView.mapType = .hybrid
        deliveryMapView.showsCompass = true
        deliveryMapView.showsScale = true
    }

    func updateMap() {
        let coordinates = CLLocationCoordinate2D(latitude:delivery.location.lat , longitude:delivery.location.lng )
        let adjustedRegion = self.deliveryMapView.regionThatFits(MKCoordinateRegion(center: coordinates, latitudinalMeters: 1500, longitudinalMeters: 1500))
        self.deliveryMapView.setRegion(adjustedRegion, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        self.deliveryMapView.addAnnotation(annotation)

// Attempt to get directions to location
//        let placemark = MKPlacemark(coordinate: coordinates)
//        let request = MKDirections.Request()
//        request.source = MKMapItem.forCurrentLocation()
//        request.destination = MKMapItem(placemark: placemark)
//        request.requestsAlternateRoutes = false
//
//        let directions = MKDirections(request: request)
//
//        directions.calculate(completionHandler: {(response, error) in
//
//            if error != nil {
//                print("Error getting directions")
//            } else {
//                self.showRoute(response)
//            }
//        })
    }

    func showRoute(_ response: MKDirections.Response?) {
        guard let response = response else {
            return
        }

        for route in response.routes {

            deliveryMapView.addOverlay(route.polyline,
                         level: MKOverlayLevel.aboveRoads)
            for step in route.steps {
                print(step.instructions)
            }
        }
    }
}

extension DeliveryDetailViewController : MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, rendererFor
        overlay: MKOverlay) -> MKOverlayRenderer {

        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
}
