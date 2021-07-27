//
//  ContentView.swift
//  Little Chicago SF App
//
//  Created by mr_robot on 7/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        NavigationView{
            
            Home()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
