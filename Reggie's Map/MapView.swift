import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var vm = MapViewModel()
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.5130, longitude: -88.99),
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    )

    var body: some View {
        Map(position: $cameraPosition) {
            // Show user's blue dot
            if let userCoord = vm.userLocation {
                Annotation("You", coordinate: userCoord) {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 12, height: 12)
                        .shadow(radius: 4)
                }
            }

            // Show building annotations
            ForEach(vm.buildings) { building in
                Annotation(building.name, coordinate: building.coordinate) {
                    VStack(spacing: 2) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title2)
                        Text(building.name)
                            .font(.caption2)
                            .fixedSize()
                    }
                    .onTapGesture {
                        vm.selectedBuilding = building
                        withAnimation {
                            cameraPosition = .region(
                                MKCoordinateRegion(
                                    center: building.coordinate,
                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                )
                            )
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .overlay(alignment: .bottom) {
            if let selected = vm.selectedBuilding {
                Button(action: {
                    openInAppleMaps(destination: selected)
                }) {
                    Text("Get Directions to \(selected.name)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
    }

    func openInAppleMaps(destination: CampusBuilding) {
        let destinationPlacemark = MKPlacemark(coordinate: destination.coordinate)
        let mapItem = MKMapItem(placemark: destinationPlacemark)
        mapItem.name = destination.name

        let launchOptions = [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
        ]

        mapItem.openInMaps(launchOptions: launchOptions)
    }
}

#Preview {
    MapView()
}
