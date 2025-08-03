//
//  DinningViewModel.swift
//  Reggie's Map
//
//  Created by angel hernandez   , Tanvai Pohare  , matt Strand , justin ray    on 6/17/25.


import Foundation
import MapKit
import CoreLocation

class DinningModelView: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var restaurants: [Restaurant] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var locationAuthorizationStatus: CLAuthorizationStatus?

    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func startSearchingNearby() {
        if let location = locationManager.location {
            currentLocation = location
            searchNearbyRestaurants(at: location, query: "")
        } else {
            locationManager.startUpdatingLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if self.currentLocation == nil {
                    self.useFallbackLocation()
                }
            }
        }
    }

    private func useFallbackLocation() {
        let isuLocation = CLLocation(latitude: 40.5128, longitude: -88.9941)
        currentLocation = isuLocation
        searchNearbyRestaurants(at: isuLocation, query: "")
    }

    private func searchNearbyRestaurants(at location: CLLocation, query: String) {
        isLoading = true
        errorMessage = nil
        restaurants = []

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query.isEmpty ? "restaurant" : "\(query) restaurant"
        request.region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                guard let self = self else { return }

                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }

                guard let mapItems = response?.mapItems else {
                    self.errorMessage = "No nearby restaurants found."
                    return
                }

                self.restaurants = mapItems.compactMap { item in
                    let coordinate = item.placemark.coordinate
                    let distanceInMeters = self.currentLocation?.distance(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) ?? 0
                    let distanceInMiles = distanceInMeters / 1609.34

                    return Restaurant(
                        name: item.name ?? "Unnamed",
                        address: item.placemark.title ?? "No Address",
                        phone: item.phoneNumber,
                        website: item.url?.absoluteString,
                        image: nil,
                        coordinate: coordinate,
                        distance: round(distanceInMiles * 10) / 10 // 1 decimal place
                    )
                }
                .sorted(by: { ($0.distance ?? 0) < ($1.distance ?? 0) })
            }
        }
    }

    func searchByRelevance(query: String) {
        if let location = locationManager.location {
            currentLocation = location
            searchNearbyRestaurants(at: location, query: query)
        } else {
            locationManager.startUpdatingLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if let location = self.locationManager.location {
                    self.currentLocation = location
                    self.searchNearbyRestaurants(at: location, query: query)
                } else {
                    self.useFallbackLocation()
                }
            }
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationAuthorizationStatus = status

        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            useFallbackLocation()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            manager.stopUpdatingLocation()
            searchNearbyRestaurants(at: location, query: "")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Location failed: \(error.localizedDescription)"
        useFallbackLocation()
    }
}
