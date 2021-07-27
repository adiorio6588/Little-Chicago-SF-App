//
//  Cart.swift
//  Little Chicago SF App
//
//  Created by mr_robot on 7/27/21.
//

import SwiftUI

struct Cart: Identifiable {
    
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
}
