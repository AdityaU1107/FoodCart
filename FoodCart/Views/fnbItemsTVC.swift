//
//  fnbItemsTVC.swift
//  FoodCart
//
//  Created by Aditya on 18/04/25.
//

import UIKit

class fnbItemsTVC: UITableViewCell {
    
    @IBOutlet weak var imageHolderView: UIView!
    @IBOutlet weak var AddBtn: UIButton!
    @IBOutlet weak var customisableBtn: UIButton!
    
    @IBOutlet weak var StepperView: UIStackView!
    @IBOutlet weak var decrementBtn: UIButton!
    @IBOutlet weak var incrementBtn: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var vegNonvegcollectionView: UIImageView!
    @IBOutlet weak var productlabel: UILabel!
    @IBOutlet weak var Pricelabel: UILabel!
    
    var addToCartAction: ((CartItem) -> Void)?
    private var currentItem: ListOfFnbItem?
    // Quantity tracking
    var quantity: Int = 0 {
            didSet {
                countLabel.text = "\(quantity)"
                updateStepperView()
                
                // Notify cart update if item is available
                if let item = currentItem {
                    let cartItem = CartItem(
                        ItemID: item.itemID,
                        ItemName: item.itemName,
                        IsVeg: item.foodType.rawValue,
                        quantity: quantity,
                        price: item.itemRate,
                        foodType: item.itemCategory,
                        PrimaryItemID: item.itemID,
                        AddOnItem: [] // Handle addons if needed
                    )
                    addToCartAction?(cartItem)
                }
            }
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageHolderView.layer.cornerRadius = 5
        imageHolderView.layer.borderWidth = 0.5
        imageHolderView.layer.borderColor = UIColor.lightGray.cgColor
        AddBtn.layer.cornerRadius = 5
        StepperView.layer.cornerRadius = 5
        StepperView.layer.borderWidth = 0.5
        StepperView.layer.borderColor = UIColor.lightGray.cgColor
        AddBtn.layer.borderWidth = 0.5
        AddBtn.layer.borderColor = UIColor.systemYellow.cgColor
        StepperView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with item: ListOfFnbItem) {
        currentItem = item
        
        productlabel.text = item.itemName
        Pricelabel.text = "₹\(item.itemRate)"
        productImageView.image = UIImage(named: item.itemImageURL)
        vegNonvegcollectionView.image = UIImage(named: item.foodType.rawValue == "veg" ? "veg" : "nonVeg")
        
        // Customisable Button Logic
        if item.addOnItems.isEmpty {
            customisableBtn.isEnabled = false
            customisableBtn.setTitle("", for: .normal)
            customisableBtn.backgroundColor = .clear // Optional: hide background if needed
        } else {
            customisableBtn.isEnabled = true
            customisableBtn.setTitle("Customisable", for: .normal)
            //customisableBtn.backgroundColor = .systemYellow // Optional styling
        }
    }
    
    // MARK: - UI Update Logic
    func updateStepperView() {
        if quantity == 0 {
            StepperView.isHidden = true
            AddBtn.isHidden = false
        } else {
            StepperView.isHidden = false
            AddBtn.isHidden = true
        }
    }

    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIButton) {
        quantity = 1
    }

    @IBAction func incrementTapped(_ sender: UIButton) {
        quantity += 1
    }

    @IBAction func decrementTapped(_ sender: UIButton) {
        if quantity > 0 {
            quantity -= 1
        }
    }
}
