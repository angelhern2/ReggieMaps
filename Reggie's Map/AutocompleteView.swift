//
//  AutocompleteView.swift
//  Reggie's Map
//
//  Created by user282482 on 7/18/25.
//

import SwiftUI
import GooglePlaces

struct AutocompleteView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var onPlaceSelected: (GMSPlace) -> Void

    func makeUIViewController(context: Context) -> GMSAutocompleteViewController {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        return autocompleteController
    }

    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: Context) {
        // No need to update
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, GMSAutocompleteViewControllerDelegate {
        let parent: AutocompleteView

        init(parent: AutocompleteView) {
            self.parent = parent
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            parent.onPlaceSelected(place)
            parent.presentationMode.wrappedValue.dismiss()
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("❌ Error: \(error.localizedDescription)")
            parent.presentationMode.wrappedValue.dismiss()
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
