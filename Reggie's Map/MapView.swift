import SwiftUI
import MapKit

struct MapView: View {
    @State private var longzoom = 0.01
    @StateObject private var vm = MapViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.5130, longitude: -88.99),
        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    )
    
    var body: some View {
        Stepper("Zoom", value: $longzoom, in: 0...1, step: 0.001)
            Map(coordinateRegion: $region, annotationItems: vm.buildings) { building in
                MapAnnotation(coordinate: building.coordinate) {
                    VStack(spacing: 2) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                        Text(building.name)
                            .font(.caption2)
                            .fixedSize()
                    }
                    .onTapGesture {
                        withAnimation {
                            region.center = building.coordinate
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }

#Preview {
    MapView()
}
