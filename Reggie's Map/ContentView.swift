//
//  ContentView.swift
//  Reggie's Map
//
//  Created by angel hernandez on 6/17/25.
//

import SwiftUI

extension Color {
    static let PrimaryColor = Color("PrimaryColor")
    static let SecondaryColor = Color("SecondaryColor")
}

struct ContentView: View {
    
    @State private var selection: Int = 0
    
    var body: some View {
        
        VStack{
            switch selection {
            case 0:
                HomeView()
                
            case 1:
                MapView()
                
            case 2:
                DinningView()
                
            case 3:
                ExploreView()
            case 4:
                SettingsView()
                
            default:
                HomeView()
            }
        }
        
        Spacer()
            HStack{
                Spacer()
                Button{
                    selection = 1
                } label: {
                    Image(systemName: "map.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                        .foregroundColor(.PrimaryColor)
                        .padding(.top, 10)
                }
                Spacer()
                Button{
                    selection = 2
                } label: {
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                        .foregroundColor(.PrimaryColor)
                        .padding(.top, 10)
                }
                Spacer()
                Button{
                    selection = 0
                } label: {
                    Image("ISU_we_teach_logo.png")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                        .padding(.top, 7)
                        
                }
                Spacer()
                Button{
                    selection = 3
                } label: {
                    Image(systemName: "newspaper.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                        .foregroundColor(.PrimaryColor)
                        .padding(.top ,10)
                }
                Spacer()
                Button{
                    selection = 4
                } label: {
                    Image(systemName: "gearshape.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                        .foregroundColor(.PrimaryColor)
                        .padding(.top ,10)
                }
                Spacer()
            }                           // hstack end
            .overlay(alignment: .top) {
            Rectangle()
                    .foregroundColor(.PrimaryColor)
                .frame(height: 1) // Adjust the height as needed
        }
          //  .background(Color("SecondaryColor"))
            .frame(height: 60 , alignment: .bottomLeading)
       
            
     
    }                                       // body end bracket
}                                           //contentview end braket




#Preview {
    ContentView()
}
