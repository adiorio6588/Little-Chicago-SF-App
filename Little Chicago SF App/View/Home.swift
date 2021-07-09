//
//  Home.swift
//  Little Chicago SF App
//
//  Created by mr_robot on 7/2/21.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        
        VStack(spacing: 10){
            
            HStack(spacing: 15){
                
                
                Button(action: {}, label: {
                    
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.black)
                })
                
                Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver To")
                    .foregroundColor(.black)
                
                Text(HomeModel.userAddress)
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(.blue)
                
                Spacer(minLength: 0)
            }
            .padding([.horizontal,.top])

            Divider()
            
            HStack(spacing: 15){
                
                TextField("Search", text: $HomeModel.search)
                
                if HomeModel.search != "" {
                    
                    Button(action: {}, label: {
                           
                            Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.gray)
                    })
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                }
            }
            .padding(.horizontal)
            .padding(.top,10)
            
            Divider()
            
            Spacer()
        }
        .onAppear(perform: {
            
            // calling location delegate....
            HomeModel.locationManager.delegate = HomeModel
        })
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
