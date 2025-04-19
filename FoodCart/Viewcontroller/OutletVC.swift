//
//  OutletVC.swift
//  FoodCart
//
//  Created by manas dutta on 18/04/25.
//

import UIKit
import CoreLocation

class OutletVC: UIViewController,CLLocationManagerDelegate, locationDelegate {
    func locationLoad(location: String) {
        
        self.LocationBtn.setTitle("📍\(location)", for: .normal)
    }
    
    
    let locationManager = CLLocationManager()
    var userCurrentLocation: CLLocation?
    var fnbItems: [ListOfFnbItem] = []
    var repeatItems: [ListOfFnbItem] = []
    var popularItems: [ListOfFnbItem] = []
    var cartItems: [CartItem] = []
    
    @IBOutlet weak var TotalAmountLbl: UILabel!
    @IBOutlet weak var LocationBtn: UIButton!
    @IBOutlet weak var addedItemsView: UIView!
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var repeatCollectionView: UICollectionView!
    @IBOutlet weak var couponCollectionView: UICollectionView!
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    
    @IBOutlet weak var categoryFilterCollectionView: UICollectionView!
    @IBOutlet weak var fnbListTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addedItemsView.layer.cornerRadius = 10
        proceedBtn.layer.cornerRadius = 10
        repeatCollectionView.register(UINib(nibName: "foodItemCVC", bundle: .main), forCellWithReuseIdentifier: "foodItemCVC") //couponCodeCVC
        couponCollectionView.register(UINib(nibName: "couponCodeCVC", bundle: .main), forCellWithReuseIdentifier: "couponCodeCVC")
        recommendCollectionView.register(UINib(nibName: "foodItemCVC", bundle: .main), forCellWithReuseIdentifier: "foodItemCVC")
        categoryFilterCollectionView.register(UINib(nibName: "filterCVC", bundle: .main), forCellWithReuseIdentifier: "filterCVC")
        fnbListTableview.register(UINib(nibName: "fnbItemsTVC", bundle: .main), forCellReuseIdentifier: "fnbItemsTVC")
        
        // Location Setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        loadFnbItems()
    }
    
    func loadFnbItems() {
        guard let url = Bundle.main.url(forResource: "fnb_items", withExtension: "json") else {
            print("JSON file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let welcomeData = try decoder.decode(Welcome.self, from: data)
            self.fnbItems = welcomeData.listOfFnbItems
            self.repeatItems = fnbItems.filter { $0.isRepeat == true }
            self.popularItems = fnbItems.filter { $0.isPopuplarItem == true }
            self.repeatCollectionView.reloadData()
            self.recommendCollectionView.reloadData()
            // ✅ At this point, you can reload your collectionView
            print("Items loaded: \(fnbItems.count)")
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userCurrentLocation = location
        locationManager.stopUpdatingLocation()
        fetchAddress(from: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location fetch failed: \(error.localizedDescription)")
    }
    
    func fetchAddress(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            guard let placemark = placemarks?.first else { return }
            
            let name = placemark.name ?? ""
            let city = placemark.locality ?? ""
            let formattedAddress = "\(name), \(city)"
            
            self.presentLocationConfirmationSheet(locationString: formattedAddress)
        }
    }
    
    func presentLocationConfirmationSheet(locationString: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let confirmVC = storyboard.instantiateViewController(withIdentifier: "confirmLocationVC") as? confirmLocationVC {
            confirmVC.modalPresentationStyle = .pageSheet
            if let sheet = confirmVC.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            confirmVC.locationText = locationString
            confirmVC.delegate = self
            self.present(confirmVC, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func locationBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let confirmVC = storyboard.instantiateViewController(withIdentifier: "confirmLocationVC") as? confirmLocationVC {
            confirmVC.modalPresentationStyle = .pageSheet
            if let sheet = confirmVC.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            confirmVC.locationText = "Dummy Florida State University,Florida"
            confirmVC.delegate = self
            self.present(confirmVC, animated: true, completion: nil)
        }
    }
    
    
}

extension OutletVC : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == repeatCollectionView{
            return repeatItems.count
        } else if collectionView == couponCollectionView{
            return 3
        }else if collectionView == recommendCollectionView {
            return popularItems.count
        }else if collectionView == categoryFilterCollectionView {
            return 3
        }
        return 3
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == repeatCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodItemCVC", for: indexPath) as! foodItemCVC
            let item = repeatItems[indexPath.row]
            
            // Styling
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.gray.cgColor
            
            // Configure UI
            cell.configure(with: item)
            
            // Cart action
            cell.addToCartAction = { [weak self] cartItem in
                guard let self = self else { return }
                if let index = self.cartItems.firstIndex(where: { $0.ItemID == cartItem.ItemID }) {
                    self.cartItems[index].quantity = cartItem.quantity
                } else {
                    self.cartItems.append(cartItem)
                }

                // Optional: print JSON
                if let jsonData = try? JSONEncoder().encode(self.cartItems),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("🛒 Cart JSON:\n\(jsonString)")
                }
            }

            return cell
            
        } else if collectionView == recommendCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodItemCVC", for: indexPath) as! foodItemCVC
            let item = popularItems[indexPath.row]
            
            // Styling
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.gray.cgColor
            
            // Configure UI
            cell.configure(with: item)
            
            // Cart action
            cell.addToCartAction = { [weak self] cartItem in
                guard let self = self else { return }
                if let index = self.cartItems.firstIndex(where: { $0.ItemID == cartItem.ItemID }) {
                    self.cartItems[index].quantity = cartItem.quantity
                } else {
                    self.cartItems.append(cartItem)
                }

                if let jsonData = try? JSONEncoder().encode(self.cartItems),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("🛒 Cart JSON:\n\(jsonString)")
                }
            }

            return cell
        }
        
        // Your other collectionViews...
        else if collectionView == couponCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "couponCodeCVC", for: indexPath) as! couponCodeCVC
            cell.layer.cornerRadius = 10
            return cell
            
        } else if collectionView == categoryFilterCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCVC", for: indexPath) as! filterCVC
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.gray.cgColor
            return cell
        }

        return UICollectionViewCell()
    }
    
    
    
}

extension OutletVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        // Providing padding around the section
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Vertical spacing between rows
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // Horizontal spacing between items
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalPadding: CGFloat = 20 + 10 // left + right insets
        let itemWidth = (collectionView.frame.width - horizontalPadding)/1.3
        let itemHeight = collectionView.frame.height - 20 // vertical padding (top + bottom)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension OutletVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fnbItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fnbItemsTVC", for: indexPath) as! fnbItemsTVC
            let item = fnbItems[indexPath.row]

            // Configure cell
            cell.configure(with: item)

            // Handle cart update
            cell.addToCartAction = { [weak self] cartItem in
                guard let self = self else { return }

                if let index = self.cartItems.firstIndex(where: { $0.ItemID == cartItem.ItemID }) {
                    self.cartItems[index].quantity = cartItem.quantity
                } else {
                    self.cartItems.append(cartItem)
                }
                
                // Optional: Print cart JSON
                if let jsonData = try? JSONEncoder().encode(self.cartItems),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("🛒 Cart JSON:\n\(jsonString)")
                }
            }
        return cell
    }
    
    
}
