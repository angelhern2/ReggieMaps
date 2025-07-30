//
//  Map.swift
//  Reggie's Map
//
//  Created by angel hernandez   , Tanvai Pohare  , matt Strand , justin ray    on 6/17/25.


import Foundation
import CoreLocation

//campus building model
struct CampusBuilding: Identifiable {
    let id = UUID()
    let buildingCode: [String]
    let name: String
    let coordinate: CLLocationCoordinate2D
}

// offices / rooms in building
struct BuildingSuggestion: Identifiable {
    let id = UUID()
    let building: CampusBuilding
    let matchedCode: String
}



