//
//  Item.swift
//  Little Chicago SF App
//
//  Created by mr_robot on 7/10/21.
//

import SwiftUI

struct Item: Identifiable {
    
    var id: String
    var item_name: String
    var item_cost: NSNumber
    var item_details: String
    var item_image: String
    var item_ratings: String
    // To Identify Whether It Is Added To Cart....
    var isAdded:  Bool = false
}
