//
//  confirmLocationVC.swift
//  FoodCart
//
//  Created by Aditya on 18/04/25.
//

import UIKit

protocol locationDelegate: AnyObject {
    func locationLoad(location:String)
}

class confirmLocationVC: UIViewController {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var ExploreBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    
    var Dummylocation = "Dummy Delhi Paras"
        var locationText = "" // this will hold fetched location
        weak var delegate: locationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ExploreBtn.layer.cornerRadius = 10
        confirmBtn.layer.cornerRadius = 10
        holderView.layer.cornerRadius = 20
        locationLabel.text = locationText
    }
    
    @IBAction func exploreTapped(_ sender: UIButton) {
            self.dismiss(animated: true)
        }

        @IBAction func confirmTapped(_ sender: UIButton) {
            delegate?.locationLoad(location: Dummylocation)
            self.dismiss(animated: true)
        }

}
