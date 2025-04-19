//
//  cartitems.swift
//  FoodCart
//
//  Created by Aditya on 19/04/25.
//

import Foundation

// MARK: - CartItem
struct CartItem: Codable {
    var ItemID: String
    var ItemName: String
    var IsVeg: String
    var quantity: Int
    var price: Double
    var foodType: String
    var PrimaryItemID: String
    var AddOnItem: [AddOnItem]
}

// MARK: - AddOnItem
struct addOnItem: Codable {
    var itemId: String
    var addonItemId: String
    var name: String
    var price: Double
    var quantity: Int
}
