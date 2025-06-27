//
//  DinningView.swift
//  Reggie's Map
//
//  Created by angel hernandez on 6/23/25.
//
import SwiftUI

struct DinningView: View {
    
    @StateObject private var allResturants = RestaurantsViewModel()
    
    
    var body: some View {
    VStack(alignment: .leading , spacing: 20){
    
        NavigationView {
        VStack{
            
            List {
                ForEach(allResturants.restaurants) { restaurant in
                        HStack
                        {
                            VStack{
                                Image(restaurant.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame( maxWidth: 60, maxHeight: 60)
                            }
                                Text(restaurant.name)
                            
                            Spacer()
                            
                            Image(systemName: "globe.americas.fill")
                                .foregroundColor(.blue)
                            Image(systemName: "arrow.trianglehead.turn.up.right.diamond")
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity , maxHeight: 80)
                        
                }
                // this is were the tool pars would go
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Nearby Food")
            .toolbar {
                //   EditButton() instead of edit button maybe a filter button
            }
        }
        }
            
        }
        
    }
}

#Preview {
    DinningView()
}

