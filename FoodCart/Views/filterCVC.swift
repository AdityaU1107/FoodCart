//
//  filterCVC.swift
//  FoodCart
//
//  Created by manas dutta on 19/04/25.
//

import UIKit

class filterCVC: UICollectionViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var uiswitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageview.isHidden = true
    }

}
