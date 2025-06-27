// this is the model which works with the Dinning model view and and the dinning view to create the dining page
//  Dinning.swift
//  Reggie's Map
//
//  Created by angel hernandez on 6/24/25.
//

import Foundation

struct Restaurant : Identifiable {
    let id: UUID = UUID()      // unique id to help us find stuff in app
    let name: String
    let address: String
    let phone: String
    let website: String
    let image: String
    
    init(name: String, address: String, phone: String, website: String, image: String) {
        self.name = name
        self.address = address
        self.phone = phone
        self.website = website
        self.image = image
    }
    
    
    
}
