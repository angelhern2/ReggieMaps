// this is the model view for the dinning page
//  DinningModelView.swift
//  Reggie's Map
//
//  Created by angel hernandez on 6/24/25.
//
import Foundation

//viewmodel
class RestaurantsViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    
    init() {
        //loadRestaurants()
        // temp load for just 1 item
        let barbqshop = Restaurant(name: "The Bar-B-Q shop", address: "1782 Maddison Ave,Memphis,TN 38104", phone: "(901) 2720-1277", website: "https://www.thebar-b-qshop.com", image: "bar-b-q-shop")
        restaurants.append(barbqshop)
        
    }
    
    func loadRestaurants() {
        // possible logic to load from database here
    }
    
    func getRestaurant(at index: Int) -> Restaurant {
        restaurants[index]
    }
    
    // more to come , depending on our needs
    
}
