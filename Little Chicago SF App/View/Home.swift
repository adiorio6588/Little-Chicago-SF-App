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
        
        ZStack{
            
            VStack(spacing: 10){
                
                HStack(spacing: 15){
                    
                    
                    Button(action: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    }, label: {
                        
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.black)
                    })
                    
                    Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver To")
                        .foregroundColor(.black)
                    
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
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
                
                if HomeModel.items.isEmpty{
                    
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer()
                }
                else{
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        VStack(spacing: 25){
                            
                            ForEach(HomeModel.filtered){item in
                                
                                // Item View...
                                
                                ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                    
                                    ItemView(item: item)
                                    
                                    HStack{
                                        
                                        Text("FREE DELIVERY")
                                            .foregroundColor(.white)
                                            .padding(.vertical,10)
                                            .padding(.horizontal)
                                            .background(Color("bg"))
                                        
                                        Spacer(minLength: 0)
                                        
                                        Button(action: {
                                            HomeModel.addToCart(item: item)
                                        }, label: {
                                            
                                            Image(systemName: item.isAdded ? "checkmark" : "plus")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(item.isAdded ? Color.gray : Color("bg"))
                                                .clipShape(Circle())
                                        })
                                    }
                                    .padding(.trailing,10)
                                    .padding(.top,10)
                                        
                                })
                                .frame(width: UIScreen.main.bounds.width - 30)
                            }
                        }
                        .padding(.top,10)
                    })
                }
            }
            
            
            // Side Menu....
                
            HStack {
                
                Menu(homeData: HomeModel)
                    // Move Effect From Left....
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
            }
            .background(
                Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                // Closing When Taps On Outside...
                    .onTapGesture(perform: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    })
            )
            
            // Non Closable Alert If Permssion Denied....
            
            if HomeModel.noLocation{
                
                Text("Please enable location access in settings to further move on.")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }
        .onAppear(perform: {
            
            // calling location delegate....
            HomeModel.locationManager.delegate = HomeModel
        })
        .onChange(of: HomeModel.search, perform: { value in
                  
            // To Avoid Continues Search Requests....
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                  
                if value == HomeModel.search && HomeModel.search != "" {
                    
                    // Search Data....
                    
                    HomeModel.filterData()
                  
                }
            }
            
            if HomeModel.search == ""{
                // Reset All Data....
                withAnimation(.linear){HomeModel.filtered = HomeModel.items}
            }
        })
    }
}

