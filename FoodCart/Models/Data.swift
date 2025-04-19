//
//  Data.swift
//  FoodCart
//
//  Created by Aditya on 19/04/25.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let status: Int
    let msg: String
    let isPopularAvailable, isRepeatAvailable: Bool
    let listOfFnbItems: [ListOfFnbItem]
    let cinemaDetails: [CinemaDetail]
}

// MARK: - CinemaDetail
struct CinemaDetail: Codable {
    let theaterName, theaterID, screenID, seat: String
    let onSeatAvailable: Bool

    enum CodingKeys: String, CodingKey {
        case theaterName
        case theaterID = "theaterId"
        case screenID = "screenId"
        case seat, onSeatAvailable
    }
}

// MARK: - ListOfFnbItem
struct ListOfFnbItem: Codable {
    let itemID, itemName, itemImageURL: String
    let itemRate: Double
    let itemOfferRate: Int
    let foodType: FoodType
    let isComboAvailable: Bool
    let comboListItems: [ComboListItem]
    let isAddOnAvailable: Bool
    let addOnItems: [AddOnItem]
    let itemCategory: String
    let isPopuplarItem, isRepeat: Bool
    let calories, itemWeight: String

    enum CodingKeys: String, CodingKey {
        case itemID = "itemId"
        case itemName, itemImageURL, itemRate, itemOfferRate, foodType, isComboAvailable, comboListItems, isAddOnAvailable, addOnItems, itemCategory, isPopuplarItem, isRepeat, calories, itemWeight
    }
}

// MARK: - AddOnItem
struct AddOnItem: Codable {
    let addonItemID, addonItemName: String
    let addonItemRate: Int

    enum CodingKeys: String, CodingKey {
        case addonItemID = "addonItemId"
        case addonItemName, addonItemRate
    }
}

// MARK: - ComboListItem
struct ComboListItem: Codable {
    let itemID: String
    let itemQty, itemRate, itemAmount, itemSaleRate: Int
    let itemSaleAmount: Int
    let itemName: String
    let foodType: FoodType
    let itemCGSTTaxPer, itemTaxValue, itemSGSTTaxPer: Double
    let itemUTGSTTaxPer, itemOtherTaxPer: Int
    let itemBasePrice, itemOfferBasePrice, itemOfferTaxValue: Double

    enum CodingKeys: String, CodingKey {
        case itemID = "itemId"
        case itemQty, itemRate, itemAmount, itemSaleRate, itemSaleAmount, itemName, foodType, itemCGSTTaxPer, itemTaxValue, itemSGSTTaxPer, itemUTGSTTaxPer, itemOtherTaxPer, itemBasePrice, itemOfferBasePrice, itemOfferTaxValue
    }
}

enum FoodType: String, Codable {
    case foodTypeVeg = "veg"
    case nonVeg = "Non Veg"
    case veg = "Veg"
}


