//
//  MapView.swift
//  Reggie's Map
//
//  Created by angel hernandez   , Tanvai Pohare  , matt Strand , justin ray    on 6/17/25.



import SwiftUI
import MapKit

struct MapView: View {
    @Binding var userSearch: String
    @Binding var searchButtonPressed: Bool

    @StateObject private var vm = MapViewModel()

    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.5130, longitude: -88.99),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )

    
    var body: some View {
          ZStack {
              // Map Layer
              Map(position: $cameraPosition, interactionModes: .all) {
                  if let userCoord = vm.userLocation {
                      Annotation("You", coordinate: userCoord) {
                          Circle()
                              .fill(Color.blue)
                              .frame(width: 14, height: 14)
                              .shadow(radius: 4)
                      }
                  }

                  ForEach(vm.selectedBuildingShowing) { building in
                      Annotation(building.name, coordinate: building.coordinate) {
                          VStack(spacing: 2) {
                              Image(systemName: "mappin.circle.fill")
                                  .foregroundColor(.red)
                                  .font(.title2)
                          }
                          .onTapGesture {
                              withAnimation {
                                  vm.selectedBuilding = building
                                  vm.selectedBuildingShowing = [building]
                                  cameraPosition = .region(
                                      MKCoordinateRegion(
                                          center: building.coordinate,
                                          span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                      )
                                  )
                                  vm.route = nil
                              }
                          }
                      }
                  }

                  if let route = vm.route {
                      MapPolyline(route.polyline)
                          .stroke(Color.blue, lineWidth: 4)
                  }
              }
              .ignoresSafeArea()

              // search
              VStack {
                  if !userSearch.isEmpty {
                      ScrollView {
                          ForEach(vm.suggestedBuildings) { suggestion in
                              Text("\(suggestion.matchedCode)")
                                  .padding(.vertical, 8)
                                  .padding(.horizontal)
                                  .frame(maxWidth: .infinity, alignment: .leading)
                                  .background(Color.white)
                                  .contentShape(Rectangle())
                                  .onTapGesture {
                                      withAnimation {
                                          vm.selectedBuilding = suggestion.building
                                          vm.selectedBuildingShowing = [suggestion.building]
                                          cameraPosition = .region(
                                              MKCoordinateRegion(
                                                  center: suggestion.building.coordinate,
                                                  span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                              )
                                          )
                                          vm.route = nil
                                      }
                                  }
                          }
                      }
                      .frame(maxHeight: 90)
                      .padding(.top)
                      .background(Color.white.opacity(0.9))
                  }

                  Spacer()

                  if let selected = vm.selectedBuilding {
                      VStack(spacing: 10) {
                          HStack {
                              Text("Directions to \(selected.name)")
                                  .font(.headline)
                              Spacer()
                              Image(systemName: "xmark")
                                  .onTapGesture {
                                      withAnimation {
                                          vm.selectedBuilding = nil
                                          vm.selectedBuildingShowing = vm.buildings
                                      }
                                  }
                          }

                          if let route = vm.route {
                              ScrollView {
                                  VStack(alignment: .leading, spacing: 4) {
                                      ForEach(route.steps, id: \.self) { step in
                                          Text(step.instructions)
                                              .font(.subheadline)
                                      }
                                  }
                              }
                              .frame(maxHeight: 200)
                          }

                          Button("Get Route") {
                              vm.calculateRoute(to: selected.coordinate)
                          }
                          .font(.headline)
                          .foregroundColor(.white)
                          .padding()
                          .frame(maxWidth: .infinity)
                          .background(Color.red)
                          .cornerRadius(10)

                          HStack(spacing: 10) {
                              Button(action: {
                                  vm.openInAppleMaps(coordinate: selected.coordinate, name: selected.name)
                              }) {
                                  Label("Apple Maps", systemImage: "map")
                                      .foregroundColor(.white)
                                      .padding()
                                      .frame(maxWidth: .infinity)
                                      .background(Color.green)
                                      .cornerRadius(10)
                              }

                              Button(action: {
                                  vm.openInGoogleMaps(coordinate: selected.coordinate)
                              }) {
                                  Label("Google Maps", systemImage: "map")
                                      .foregroundColor(.white)
                                      .padding()
                                      .frame(maxWidth: .infinity)
                                      .background(Color.green)
                                      .cornerRadius(10)
                              }
                          }
                      }
                      .padding()
                      .background(.ultraThinMaterial)
                      .cornerRadius(12)
                      .padding()
                  }
              }
          }
          .onChange(of: userSearch) {
              withAnimation {
                  vm.searchText = userSearch
              }
          }
          .onChange(of: searchButtonPressed) {
              withAnimation {
                  vm.searchText = userSearch
                  vm.selectedBuildingShowing = vm.suggestedBuildings.map { $0.building }
                  searchButtonPressed = false
              }
          }
      }
  }
    
 






            
            
