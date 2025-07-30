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



