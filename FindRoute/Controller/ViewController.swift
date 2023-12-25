//
//  ViewController.swift
//  FindRoute
//
//  Created by Кирилл Арефьев on 19.12.2023.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
	
	private var annotationsArray = [MKPointAnnotation]()
	
	private let mapView: MKMapView = {
		let map = MKMapView()
		map.translatesAutoresizingMaskIntoConstraints = false
		
		return map
	}()
	
	private let addAdressButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "addAdressButton"), for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		
		return button
	}()
	
	private let resetButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "resetButton"), for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.isHidden = true
		
		return button
	}()
	
	private let routeButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "routeButton"), for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.isHidden = true
		
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.delegate = self
		setMapView()
		setButtonMapView()
	}
}

extension ViewController {
	func setMapView() {
		view.addSubview(mapView)
		NSLayoutConstraint.activate([
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	func setButtonMapView() {
		view.addSubview(addAdressButton)
		view.addSubview(resetButton)
		view.addSubview(routeButton)
		
		addAdressButton.addTarget(self, action: #selector(touchAddAdress), for: .touchUpInside)
		resetButton.addTarget(self, action: #selector(touchResetButton), for: .touchUpInside)
		routeButton.addTarget(self, action: #selector(touchRouteButton), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			addAdressButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
			addAdressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			addAdressButton.heightAnchor.constraint(equalToConstant: 32),
			addAdressButton.widthAnchor.constraint(equalToConstant: 90)
		])
		
		NSLayoutConstraint.activate([
			resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
			resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			resetButton.heightAnchor.constraint(equalToConstant: 32),
			resetButton.widthAnchor.constraint(equalToConstant: 90)
		])
		
		NSLayoutConstraint.activate([
			routeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
			routeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			routeButton.heightAnchor.constraint(equalToConstant: 32),
			routeButton.widthAnchor.constraint(equalToConstant: 90)
		])
	}
	
	@objc func touchAddAdress() {
		alertAddAdress(title: "Add address", placeholder: "Write address") { [self] text in
			setupPlacemark(adressPlace: text)
		}
	}
	
	@objc func touchResetButton() {
		mapView.removeOverlays(mapView.overlays)
		mapView.removeAnnotations(mapView.annotations)
		annotationsArray = [MKPointAnnotation]()
		routeButton.isHidden = true
		resetButton.isHidden = true
	}
	
	@objc func touchRouteButton() {
		for index in 0 ... annotationsArray.count - 2 {
			createDirectionRequest(startCoordinate: annotationsArray[index].coordinate, destinationCoordinate: annotationsArray[index + 1].coordinate)
		}
		mapView.showAnnotations(annotationsArray, animated: true)
	}
	
	private func setupPlacemark(adressPlace: String) {
		let geocoder = CLGeocoder()
		
		geocoder.geocodeAddressString(adressPlace) { [self] ( placemarks, error ) in
			if let error = error {
				print(error)
				alertError(title: "Error", message: "Try writing the address again")
				return
			}
			
			guard let placemarks = placemarks else { return }
			let placemark = placemarks.first
			
			let annotation = MKPointAnnotation()
			annotation.title = adressPlace
			
			guard let placemarkLocation = placemark?.location else { return }
			annotation.coordinate = placemarkLocation.coordinate
			annotationsArray.append(annotation)
			
			if annotationsArray.count > 2 {
				routeButton.isHidden = false
				resetButton.isHidden = false
			}
			
			mapView.showAnnotations(annotationsArray, animated: true)
		}
	}
	
	private func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
		let startLocation = MKPlacemark(coordinate: startCoordinate)
		let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
		
		let request = MKDirections.Request()
		request.source = MKMapItem(placemark: startLocation)
		request.destination = MKMapItem(placemark: destinationLocation)
		request.transportType = .walking
		request.requestsAlternateRoutes = true
		
		let direction = MKDirections(request: request)
		direction.calculate { response, error in
			if let error = error {
				print(error)
				return
			}
			
			guard let response = response else {
				self.alertError(title: "Error", message: "The route is not available")
				return
			}
			
			var minRoute = response.routes[0]
			for route in response.routes {
				minRoute = (route.distance < minRoute.distance) ? route : minRoute
			}
			
			self.mapView.addOverlay(minRoute.polyline)
		}
	}
}

extension ViewController: MKMapViewDelegate {
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
		render.strokeColor = .green
		
		return render
	}
}
