//
//  Dinning.swift
//  Reggie's Map
//
//  Created by angel hernandez   , Tanvai Pohare  , matt Strand , justin ray    on 6/17/25.


import Foundation
import CoreLocation

struct Restaurant: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let phone: String?
    let website: String?
    let image: String?
    let coordinate: CLLocationCoordinate2D?
    let distance: Double?    // distance in miles
}
