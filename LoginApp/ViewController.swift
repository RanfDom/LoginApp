//
//  ViewController.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 28/10/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import MapKit
import NVActivityIndicatorView

//import CoreData

class ViewController: UIViewController, LoadableViewController {
    static var storyboardFileName: String = "Main"

    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager!
    var currentLocationStr: String = ""
    
//    let objectModel: NSManagedObjectModel
//    let managedObject: NSManagedObject
//    let context: NSManagedObjectContext
//    let description: NSEntityDescription
//    let request: NSFetchRequest
    
    var activityIndicator: NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        map.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator = NVActivityIndicatorView(frame: map.frame, type: .ballDoubleBounce, color: .blue, padding: 0.5)
        determineCurrentLocation()
        
        guard let url: URL = URL(string: "https://rapidapi.p.rapidapi.com/current") else {
            errorAppeared()
            return
        }
        
        let headers = [
            "x-rapidapi-key": "ae6e46d234mshe1c4c4a265082dep116db9jsna16eae645ee6",
            "x-rapidapi-host": "weatherbit-v1-mashape.p.rapidapi.com"
        ]
        
        let params = [
            "lat" : "19.3934164",
            "lon" : "-99.1616135",
            "lang" : "es"
        ]
        
        getWeatherAlamofireWith(url, headers: headers, params: params)
        //getWeatherURLSessionWith(url, headers: headers, params: params)
    }
    
    private func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                // No access
                requestUpdateSetting()
            case .authorizedWhenInUse, .authorizedAlways:
                //map.showsUserLocation = true
                locationManager.startUpdatingLocation()
                map.showsUserLocation = true
            }
        } else {
            print("Location services not enabled")
        }
    }
    
    private func requestUpdateSetting() {
        let alert: UIAlertController = UIAlertController(title: "Permisos de ubicación", message: "Para continuar acepta los permisos de ubicación desde la configuración de tu aplicativo", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ir a configuraciones", style: .default, handler: { (_) in
            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getWeatherAlamofireWith(_ url: URL, headers: [String:String], params: [String:String]) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url,
                   parameters: params,
                   headers: HTTPHeaders(headers)).responseDecodable(of:WeatherData.self, decoder: decoder) { [weak self] response in
                    switch response.result {
                    case .success(let weatherData):
                        guard let weather: ZoneWeather = weatherData.data?.first else { return }
                        self?.presentWeatherWith(weather)
                    case .failure(let error):
                        print("Something whent wrong: \(error)")
                    }
        }
    }
    
    private func getLocationTitle(lattitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lattitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location) { (place, error) in
            guard let place = place else { return }
            guard let city = place.first?.subAdministrativeArea else { return }
            self.currentLocationStr = city
        }
        
        return currentLocationStr
    }
    
    private func presentWeatherWith(_ zoneWeather: ZoneWeather ) {
        // present Alert
        print(zoneWeather)
    }
    
    private func getWeatherURLSessionWith(_ url: URL, headers: [String: String], params: [String:String]) {
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        }
        
        dataTask.resume()
    }

    private func errorAppeared() {
        // manage error
        print("URL invalida")
    }

    private func createRequest(from origin: MKPlacemark, to destination: MKPlacemark) -> MKDirections.Request? {
        let request: MKDirections.Request = MKDirections.Request()
        request.source = MKMapItem(placemark: origin)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .walking
        
        return request
    }
    
    private func drawRoute(from origin: MKPlacemark, to destination: MKPlacemark) {
        guard let request = createRequest(from: origin, to: destination) else { return }
        let directions = MKDirections(request: request)
        
        directions.calculate { (response, error) in
            guard let response = response else { return }
            let routes = response.routes
            
            for route in routes {
                self.map.addOverlay(route.polyline)
                self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocation = locations.first else { return }
        
        let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: center, latitudinalMeters: 4000, longitudinalMeters: 4000)
        
        map.setRegion(region, animated: true)
        
        //Parque delta 19.3980268,-99.1573184
        let mapAnnotation: MKPointAnnotation = MKPointAnnotation()
        mapAnnotation.coordinate = CLLocationCoordinate2D(latitude: 19.3980268, longitude: -99.1573184)
        mapAnnotation.title = getLocationTitle(lattitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        map.addAnnotation(mapAnnotation)
        
        let origin = MKPlacemark(coordinate: center)
        let destination = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.3980268, longitude: -99.1573184))
        drawRoute(from: origin, to: destination)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .red
        render.lineWidth = 5
        return render
    }
}
