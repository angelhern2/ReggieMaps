//
//  DinningView.swift
//  Reggie's Map
//
//  Created by angel hernandez   , Tanvai Pohare  , matt Strand , justin ray    on 6/17/25.


import SwiftUI
import MapKit

struct DinningView: View {
    @StateObject private var viewModel = DinningModelView()
    
    var userSearch: String?
    @Binding var searchButtonPressed: Bool

    var body: some View {
        NavigationView {
            VStack {
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
                    List(viewModel.restaurants) { restaurant in
                        HStack(alignment: .top) {
                            // Left side: Restaurant info
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
                                    Text("Phone: \(phone)")
                                        .font(.footnote)
                                }
                                if let website = restaurant.website {
                                    Text("Website: \(website)")
                                        .font(.footnote)
                                        .foregroundColor(.blue)
                                }
                            }
                            Spacer()
                            // Right side: Open in Maps button
                            Button(action: {
                                openInMaps(restaurant: restaurant)
                            }) {
                                Image(systemName: "map")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.blue)
                                    .padding(8)
                            }
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .buttonStyle(PlainButtonStyle()) // prevent row highlight on tap
                        }
                        .padding(.vertical, 6)
                    }
                    .listStyle(InsetGroupedListStyle())
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
                .accessibilityLabel("Refresh")
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
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}
