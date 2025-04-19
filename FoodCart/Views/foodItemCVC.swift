//
//  foodItemCVC.swift
//  FoodCart
//
//  Created by Aditya on 18/04/25.
//

import UIKit

class foodItemCVC: UICollectionViewCell {

    @IBOutlet weak var AddBtn: UIButton!
    @IBOutlet weak var decrementBtn: UIButton!
    @IBOutlet weak var incrementBtn: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var StepperView: UIStackView!
    @IBOutlet weak var stepperstackview: UIStackView!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var vegNonVegimageview: UIImageView!
    
    // Track quantity
        var quantity: Int = 0 {
            didSet {
                countLabel.text = "\(quantity)"
                updateStepperVisibility()
            }
        }
    
    var addToCartAction: ((CartItem) -> Void)?

        private var currentItem: ListOfFnbItem?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        AddBtn.layer.cornerRadius = 5
        AddBtn.layer.borderWidth = 0.5
        AddBtn.layer.borderColor = UIColor.systemYellow.cgColor
        StepperView.layer.cornerRadius = 5
        StepperView.layer.borderWidth = 0.5
        StepperView.layer.borderColor = UIColor.lightGray.cgColor
        stepperstackview.isHidden = true
        stepperstackview.layer.cornerRadius = 5
        stepperstackview.layer.borderWidth = 0.5
        stepperstackview.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    private func updateStepperVisibility() {
           if quantity == 0 {
               AddBtn.isHidden = false
               stepperstackview.isHidden = true
           } else {
               AddBtn.isHidden = true
               stepperstackview.isHidden = false
           }
       }

    func configure(with item: ListOfFnbItem) {
            currentItem = item
            foodNameLbl.text = item.itemName
            priceLbl.text = "₹\(item.itemRate)"
            imageview.image = UIImage(named: item.itemImageURL)

            // Veg/Non-veg indicator
            switch item.foodType.rawValue.lowercased() {
            case "veg":
                vegNonVegimageview.image = UIImage(named: "veg")
            case "non veg", "nonveg":
                vegNonVegimageview.image = UIImage(named: "nonVeg")
            default:
                vegNonVegimageview.image = nil
            }
        }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
            quantity = 1
        if let item = currentItem {
                    let cartItem = CartItem(
                        ItemID: item.itemID,
                        ItemName: item.itemName,
                        IsVeg: item.foodType.rawValue,
                        quantity: quantity,
                        price: item.itemRate,
                        foodType: "1", // Replace with actual if needed
                        PrimaryItemID: item.itemID,
                        AddOnItem: [] // Handle Add-ons if needed
                    )
                    addToCartAction?(cartItem)
                }
        }
        
        @IBAction func incrementTapped(_ sender: UIButton) {
            quantity += 1
            updateCart()
        }
        
        @IBAction func decrementTapped(_ sender: UIButton) {
            if quantity > 0 {
                quantity -= 1
                updateCart()
            }
        }
    
    private func updateCart() {
            if let item = currentItem {
                let cartItem = CartItem(
                    ItemID: item.itemID,
                    ItemName: item.itemName,
                    IsVeg: item.foodType.rawValue,
                    quantity: quantity,
                    price: item.itemRate,
                    foodType: "1",
                    PrimaryItemID: item.itemID,
                    AddOnItem: []
                )
                addToCartAction?(cartItem)
            }
        }
}
