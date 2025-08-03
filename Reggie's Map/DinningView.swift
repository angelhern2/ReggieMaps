import SwiftUI
import MapKit

struct DinningView: View {
    @StateObject private var viewModel = DinningModelView()

    var userSearch: String?
    @Binding var searchButtonPressed: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }

                if viewModel.isLoading {
                    ProgressView("Searching nearby restaurants...")
                        .padding()
                } else if viewModel.restaurants.isEmpty {
                    Text("No restaurants found nearby.")
                        .padding()
                } else {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.restaurants) { restaurant in
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(restaurant.name)
                                        .font(.headline)

                                    Text(restaurant.address)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)

                                    if let distance = restaurant.distance {
                                        Text(String(format: "%.1f miles away", distance))
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                    }

                                    if let phone = restaurant.phone {
                                        let phoneDigits = phone.filter { $0.isNumber }
                                        if let phoneURL = URL(string: "tel://\(phoneDigits)") {
                                            Link("📞 \(phone)", destination: phoneURL)
                                                .font(.footnote)
                                                .foregroundColor(.blue)
                                        }
                                    }

                                    if let website = restaurant.website {
                                        let formatted = website.hasPrefix("http") ? website : "https://\(website)"
                                        if let url = URL(string: formatted) {
                                            Link("🌐 \(formatted)", destination: url)
                                                .font(.footnote)
                                                .foregroundColor(.blue)
                                                .lineLimit(1)
                                                .truncationMode(.middle)
                                        }
                                    }
                                }

                                Spacer()

                                Button(action: {
                                    openInMaps(restaurant: restaurant)
                                }) {
                                    Image(systemName: "map.fill")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                                .accessibilityLabel("Open in Maps")
                            }
                            .padding()
                            .background(Color(UIColor.systemGroupedBackground))
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
                        }
                    }
                    .padding()
                }
            }
            .onChange(of: searchButtonPressed) { pressed in
                if pressed {
                    viewModel.searchByRelevance(query: userSearch ?? "")
                    searchButtonPressed = false
                }
            }
            .navigationTitle("Nearby Restaurants")
            .toolbar {
                Button(action: {
                    viewModel.startSearchingNearby()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            .onAppear {
                viewModel.startSearchingNearby()
            }
        }
    }

    private func openInMaps(restaurant: Restaurant) {
        guard let coordinate = restaurant.coordinate else { return }
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = restaurant.name
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}
